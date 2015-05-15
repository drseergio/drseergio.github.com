---
layout: post
title: "Updates to the 802.11ac guide"
date: 2015-05-05 18:16
comments: true
categories: diy
---

I have previuosly written a [guide to configure a 802.11ac access point using hostapd in gentoo linux](/blog/2015/02/01/beginners-guide-to-802-dot-11ac-setup/). Another enthusiast discovered that my guide does not lead to a working access point. Turns out I missed crucial steps to configure DFS which is required for operating on higher frequencies. In this guide I diagnose the problem and correct the mistakes. I also show how to increase transmission (TX) power of the wireless card.

## Diagnose the issue

First, let's see what's wrong with the existing configuration. We will look at the daemon output to troubleshoot. Stop the hostapd service and then start it manually in foreground with:

{% codeblock %}
ap linux # hostapd -d /etc/hostapd/hostapd.conf

...
Completing interface initialization
Mode: IEEE 802.11a  Channel: 52  Frequency: 5260 MHz
DFS 4 channels required radar detection
DFS all channels available, (SKIP CAC): no
DFS 0 chans unavailable - choose other channel: no
wlp4s0: interface state HT_SCAN->DFS
DFS start CAC on 5260 MHz
wlp4s0: DFS-CAC-START freq=5260 chan=52 sec_chan=1, width=1, seg0=62, seg1=0, cac_time=60s
Can't set freq params
DFS start_dfs_cac() failed, -1
Interface initialization failed
wlp4s0: interface state DFS->DISABLED
wlp4s0: AP-DISABLED
...
{% endcodeblock %}

The output shows us that hostapd was unable to start due to DFS failure (line "DFS start_dfs_cac() failed, -1"). It means that DFS is not available so we can't choose a channel that requires DFS. We can double check the local regulations using:

{% codeblock %}
ap ~ # iw reg get
country CH: DFS-ETSI
        (2402 - 2482 @ 40), (N/A, 20), (N/A)
        (5170 - 5250 @ 80), (N/A, 20), (N/A)
        (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS
        (5490 - 5710 @ 160), (N/A, 27), (0 ms), DFS
        (57000 - 66000 @ 2160), (N/A, 40), (N/A)
{% endcodeblock %}

The output shows that frequencies above 5250 Mhz require DFS. This means that channels >52 won't work unless DFS is functional. Let's cross check supported radio channels using "iw":

{% codeblock %}
ap ~ # iw list
...
Frequencies:
    * 5180 MHz [36] (17.0 dBm)
    * 5200 MHz [40] (17.0 dBm)
    * 5220 MHz [44] (17.0 dBm)
    * 5240 MHz [48] (17.0 dBm)
    * 5260 MHz [52] (20.0 dBm) (no IR, radar detection)
        DFS state: usable (for 62 sec)
        DFS CAC time: 60000 ms
    * 5280 MHz [56] (20.0 dBm) (no IR, radar detection)
        DFS state: usable (for 62 sec)
        DFS CAC time: 60000 ms
...
{% endcodeblock %}

"no IR" stands for "no initiate radiation". It essentially means that the card cannot be used as an access point on that frequency. However, when "no IR" goes in hand with "radar detection" it means that the card can be used but only with DFS. It's another reminder that DFS is required.

## Fix the issue by disabling DFS

An obvious solution is to avoid using DFS by choosing a channel that does not require radar detection. In the case of Switzerland channel 44 is a safe choice.

To disable DFS and to choose a channel that does not require DFS do following changes to the configuration file:

{% codeblock %}
ap ~ # vi /etc/hostapd/hostapd.conf

...
channel=44
...
ieee80211h=0
...
{% endcodeblock %}

Save the changes and restart hostapd. Everything should work now. Enabling DFS is by no means necessary. In fact, I'm running my access point on a frequency which does not require DFS. I observe significantly better transfer rates on non-DFS channels.

However, if you're curious and/or would like to get DFS to work read on.

## Enable DFS support in the kernel

It turns out that DFS must be enabled in kernel and by default the option is hidden from kernel configuration dialogs. To check if DFS is enabled look through kernel message output:

{% codeblock %}
ap ~ # dmesg
...
[    2.850086] ath10k_pci 0000:04:00.0: debug 1 debugfs 1 tracing 0 dfs 0 testmode 0
...
{% endcodeblock %}

The output indicates that DFS is disabled ("dfs 0"). To enable DFS you must enable following options:

 * "Configure standard kernel features (expert users)" under "General Setup"
 * "cfg80211 certification onus" under "Networking support > Wireless"
 * "Atheros DFS support for certified platforms" under "Device Drivers > Network device support > Wireless LAN > Atheros Wireless Cards"

Re-compile the kernel and verify if the kernel output indicates DFS support. Then, re-enable DFS and choose a higher channel of your liking.

I have experimented with the higher channels but I discovered throughput was significantly worse. In addition, not all client machines recognize upper 5Ghz channels. For example, EU version of Asus PCE-AC68 card in Windows doesn't function on channels >48. A [work-around soltion](http://www.snbforums.com/threads/pce-ac66-wifi-card-not-picking-up-5ghz-149-161-channels.10932/) is to alter the driver's *.ini file and re-install the driver:

{% codeblock %}
After install find the driver's INF in C:\Program Files (x86)\ASUS\PCE-AC68 WLAN Card Utilities\Driver\PCE-AC68\Win81\bcmwl64.inf

Here is the modified lines on the INF to make the card working with channels >= 149 :

- Line 3784, section [a.channels.reg], under the comment "Additional channels supported only on SPROM map version 2" : uncomment the next five lines to enable channels 149 to 165.

- Line 3356, section [common.reg] : uncomment each lines containing Ndi\params\Country (lines 3356 to 3598)

To continue, you must uninstall (with removing) the driver with the windows device manager and deactivate windows driver integrity check with an admin console:

bcdedit -set loadoptions DISABLE_INTEGRITY_CHECKS
bcdedit -set TESTSIGNING ON

After rebooting, go to the device manager and install the modified INF on the newly discovered uknown network adapter.

After installtion, got to the PCE-AC68 adapter's properties in the device manager, in the advance section you can choose the country (for channel 149, i've chosen %UnitedState%).
{% endcodeblock %}

## Fix DFS-UNSET problem

If you're seeing "DFS-UNSET" in "iw reg get" output upgrade crda package to at least version 3.18.

## Increase TX power

Local regulations dictate maximum radiation power and operating frequencies. Certain radios are hard-coded to geographical regions, e.g. United States. Regulatory compliance software runs the strictest set of rules that intersect the pre-programmed and chosen regions. In other words, a radio that is pre-programmed for US and is operated in Switzerland will disable channels that are prohibited in US but perfectly legal in Switzerland. Same goes for power. Radio will operate on the lowest power allowed in the two regions. To overcome these limitations it is sometimes possible to re-program the radio's EEPROM and set a different region.

A simpler solution is to alter the regulations which are maintained by the wireless software stack and not the radio itself. On Linux the idea is to compile a custom regulatory daemon which allows a modified set of regulations. The regulations themselves are modified by replacing entries corresponding to the hard-coded radio region to whatever is desired by the user:

 1. download wireless-regdb package, unpack
 2. modify "db.txt" file by replacing entries corresponding to the radio's region with desired configuration. In my case I search for Swiss regulations (CH) and copy them over the rules for US and 00 (00 stands for global).
 3. run "make"
 4. copy generated rule set out: cp regulatory.bin /usr/lib/crda/regulatory.bin
 5. download crda package, unpack
 6. copy *pem files from wireless-regdb folder to crda/pubkeys subfolder
 7. run "make", followed by "make install"
 8. reboot
 
This procedure generates a custom regulatory daemon that trusts the set of regulations we have altered. Obviously, these changes won't persist after a package upgrade so you would need to repeat them should newer packages get released.

It's not difficult to inadvertently break your local laws by altering regulatory restrictions so be careful with the changes. Try also not to fry yourself with radiation.