---
title: "Customized disposable desktop VMs, fast!"
subtitle: "Provisioning VMs on-demand from scratch with Vagrant, Packer and Arch Linux"
date: 2018-03-07T12:57:58+01:00
tags: [linux]
draft: false
categories: [pro]
---

I've been running virtualized desktop environments for a couple of years now, doing various tasks from within Virtualbox VMs. I like the fact the tools and libraries for the job at hand are isolated from other environments. But I have been missing on the dynamic aspect, somehow ending up with VMs which are as prone to maintenance as physical installations. Recently, I've decided to solve this issue once and for all with the help from [Arch Linux](https://www.archlinux.org/), [Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io).

<!--more-->

## Virtual Machine maintenance chores

My host operating system has relatively few things installed. A terminal client, a browser, some productivity tools and Virtualbox. I carry out most of tasks and projects from within VMs, and that includes my full-time software engineering duties. That way I don't have to worry about hardware compatibility and at the same time enjoy my favorite development tools. With VMs I'm never concerned about mixing dependencies. Side projects can't disrupt my main project because they're running in isolated VMs. There's a perceptible hit on UI responsiveness and usability, even with 3D acceleration enabled, but the benefits outweigh the costs and I consider the performance acceptable.

Yet my biggest concern was not the UI performance but the ongoing maintenance. Virtual machines offer the prospect of cheap and disposable instances that are easy to provision and destroy whenever necessary. In reality, however, I ended up with several VMs that were maintained just as if they were physical machines. I was also concerned about losing them. For that reason I kept their backups. It is certainly easier to backup VMs and recover than physical machines but that's far from the dream of on-demand disposable instances.

Getting a new VM to usable state was also a chore. I chose Ubuntu because it is widely used and supported but it comes prepackaged with hundreds of programs. Every time it took me a couple of hours to get rid of all the stuff I don't need and a couple of days until I've got everything set up the way I like it. My favorite distribution is Gentoo but that would be too much work and compile time for every single VM. Installing Gentoo every time would be a nightmare. And upgrading all the VMs even more so. Nowadays, I keep Gentoo on custom routers and servers only.

I have decided to use this opportunity to come with a scripted solution to make the best use of disposable VMs. My goal was to create customizable VMs that are built from scratch and include only the packages I want.

## Time for a new Linux distro

Before building out the infrastructure I chose Arch Linux as the base distribution. Arch is as flexible as Gentoo, sans the compilation. A minimal Arch system contains very few packages. It was a natural choice and a much wanted upgrade from the Ubuntu images I had been using.

## Automated VM provisioning

I already had a tool in mind - [Vagrant](https://www.vagrantup.com). I remember trying it years ago so I vaguely recalled it could help me automate VM management. Vagrant integrates nicely with Virtualbox, which I'm using to run all my VMs. Vagrant provisions VMs from configuration files using a specified base box. After studying Vagrant documentation I have realized that having a base box is a requirement. In other words, Vagrant cannot build a complete system from scratch, i.e. from an installation ISO. Using someone else's Arch base image is unacceptable to me as it defies the purpose -- I can't be sure there's no superflous software installed. I wanted a solution that produces VMs from scratch: partitioning, bootloader installation, etc.

Luckily, the company behind Vagrant also provides a tool called [Packer](https://packer.io). Packer fills the gap by building base images from scripts. The combination of Vagrant + Packer is perfect for getting complete VMs from scratch. The way Packer works is rather spectacular. First, it boots the VM and programmatically types commands in the terminal -- a somewhat unusual sight. The commands Packer types download a script from a shared folder and runs it. The script then sets up SSH to which Packer connects to. From there on no direct interaction is needed and further steps are executed through SSH.

## Learning Arch

With the tools in hand, my first step was to experiment with Arch and install it manually under Virtualbox while documenting every step. I chose EFI, grub and btrfs, among other things. The beauty of the setup is, that once a script works, I can change and test these small things without going through the whole setup manually. It is like unit testing. While Arch is not Gentoo it still takes effort to build. I first built a base cli system and then built a minimal X system.

## Building base box with Packer

Once the Arch installation steps were complete I began with the corresponding Packer script. I looked for and discovered a couple of existing examples online and added my changes on top. The complete script is roughly 100 lines long and takes care of everything -- partitioning, installing bootloader, setting up locales and network, installing Virtualbox modules and few essential packages (e.g. ssh, neovim). The goal of the base image is to be as light as possible -- other tools are installed later through Vagrant.

{{< highlight bash >}}
#!/usr/bin/env bash

# stop on errors
set -eu

DISK='/dev/sda'

FQDN='arch.bethania'
KEYMAP='us'
LANGUAGE='en_US.UTF-8'
PASSWORD=$(/usr/bin/openssl passwd -crypt 'vagrant')
TIMEZONE='Europe/Zurich'

CONFIG_SCRIPT='/usr/local/bin/arch-config.sh'
BOOT_PARTITION="${DISK}1"
ROOT_PARTITION="${DISK}2"
TARGET_DIR='/mnt'
MIRRORLIST="https://www.archlinux.org/mirrorlist/?country=${COUNTRY}&protocol=http&protocol=https&ip_version=4&use_mirror_status=on"

echo "==> Create GPT partition table on ${DISK}"
/usr/bin/sgdisk -og ${DISK}

echo "==> Destroying magic strings and signatures on ${DISK}"
/usr/bin/dd if=/dev/zero of=${DISK} bs=512 count=2048
/usr/bin/wipefs --all ${DISK}

echo "==> Creating /boot EFI partition on ${DISK}"
/usr/bin/sgdisk -n 1:2048:2098175 -c 1:"EFI boot partition" -t 1:ef00 ${DISK}

echo "==> Creating /root partition on ${DISK}"
ENDSECTOR=`/usr/bin/sgdisk -E ${DISK}`
/usr/bin/sgdisk -n 2:2098176:$ENDSECTOR -c 2:"Linux root partition" -t 2:8300 ${DISK}

echo '==> Creating /boot filesystem (FAT32)'
/usr/bin/mkfs.fat -F32 $BOOT_PARTITION

echo '==> Creating /root filesystem (btrfs)'
/usr/bin/mkfs.btrfs $ROOT_PARTITION

echo "==> Mounting ${ROOT_PARTITION} to ${TARGET_DIR}"
/usr/bin/mount ${ROOT_PARTITION} ${TARGET_DIR}
echo "==> Mounting ${BOOT_PARTITION} to ${TARGET_DIR}/boot"
/usr/bin/mkdir ${TARGET_DIR}/boot
/usr/bin/mount ${BOOT_PARTITION} ${TARGET_DIR}/boot

echo "==> Setting local mirror"
curl -s "$MIRRORLIST" |  sed 's/^#Server/Server/' > /etc/pacman.d/mirrorlist

echo '==> Bootstrapping the base installation'
/usr/bin/pacstrap ${TARGET_DIR} base base-devel btrfs-progs neovim openssh grub efibootmgr net-tools

echo '==> Generating the filesystem table'
/usr/bin/genfstab -U ${TARGET_DIR} >> "${TARGET_DIR}/etc/fstab"

echo '==> Installing GRUB'
/usr/bin/sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' "${TARGET_DIR}/etc/default/grub"
/usr/bin/sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="quiet video=1360x768"/' "${TARGET_DIR}/etc/default/grub"

echo '==> Generating the system configuration script'
/usr/bin/install --mode=0755 /dev/null "${TARGET_DIR}${CONFIG_SCRIPT}"

cat <<-EOF > "${TARGET_DIR}${CONFIG_SCRIPT}"
    # GRUB bootloader installation
    /usr/bin/grub-install --target=x86_64-efi --efi-directory=/boot
    /usr/bin/grub-mkconfig -o /boot/grub/grub.cfg
    /usr/bin/mkdir /boot/EFI/BOOT
    /usr/bin/cp /boot/EFI/arch/grubx64.efi /boot/EFI/BOOT/bootx64.efi

	echo '${FQDN}' > /etc/hostname
	/usr/bin/ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
	echo 'KEYMAP=${KEYMAP}' > /etc/vconsole.conf
	echo 'LANG=en_US.UTF-8' > /etc/locale.conf
	/usr/bin/sed -i 's/#${LANGUAGE}/${LANGUAGE}/' /etc/locale.gen
	/usr/bin/locale-gen
	/usr/bin/usermod --password ${PASSWORD} root
	# https://wiki.archlinux.org/index.php/Network_Configuration#Device_names
	/usr/bin/ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
	/usr/bin/ln -s '/usr/lib/systemd/system/dhcpcd@.service' '/etc/systemd/system/multi-user.target.wants/dhcpcd@eth0.service'
	/usr/bin/sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
	/usr/bin/systemctl enable sshd.service

	# Vagrant-specific configuration
	/usr/bin/useradd --password ${PASSWORD} --comment 'Vagrant User' --create-home --user-group vagrant
	echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_vagrant
	echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
	/usr/bin/chmod 0440 /etc/sudoers.d/10_vagrant
	/usr/bin/install --directory --owner=vagrant --group=vagrant --mode=0700 /home/vagrant/.ssh
	/usr/bin/curl --output /home/vagrant/.ssh/authorized_keys --location https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
	/usr/bin/chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
	/usr/bin/chmod 0600 /home/vagrant/.ssh/authorized_keys

    # virtualbox integration
    /usr/bin/pacman -S --noconfirm virtualbox-guest-utils-nox virtualbox-guest-modules-arch 
    echo -e 'vboxguest\nvboxsf\nvboxvideo' > /etc/modules-load.d/virtualbox.conf
    /usr/bin/systemctl enable vboxservice.service
    /usr/bin/systemctl enable rpcbind.service
    # Add groups for VirtualBox folder sharing
    /usr/bin/usermod --append --groups vagrant,vboxsf vagrant

    # Clean the pacman cache.
    /usr/bin/yes | /usr/bin/pacman -Scc
    /usr/bin/pacman-optimize
EOF

echo '==> Entering chroot and configuring system'
/usr/bin/arch-chroot ${TARGET_DIR} ${CONFIG_SCRIPT}
rm "${TARGET_DIR}${CONFIG_SCRIPT}"

echo '==> Installation complete!'
/usr/bin/sleep 3
/usr/bin/umount ${TARGET_DIR}/boot
/usr/bin/umount ${TARGET_DIR}
{{< /highlight >}}

Packer produces a base box which can then be imported into vagrant and specified in vagrant configuration files:
```
$ ./packer.exe build -force arch-base.json
$ ./vagrant.exe box add output/arch_vagrant_base.box --name arch-base --force
```

## Defining VMs in Vagrant

With the most minimal base image produced, Vagrant steps in to fully define what goes into the VMs. Vagrant is flexible and supports Puppet, Chef and Ansible for provisioning. As I didn't have experience with any of those tools and since I only needed the setup for myself I decided to avoid complexity. Vagrant also supports plain shell scripts, which are sufficiently expressive and simple.

I chose to structure provisioning scripts in a layering scheme, in which layers are executed in succession to add functionality. I came up with 2 layers: CLI and X. CLI installs everything I'd want on a console VM, including tools, SSH keys, shell customizations, etc. Similarly, the X layer installs a minimal system with XFCE, a launcher, Sublime editor (along with my personal license), fonts, browser and my favorite diff tool. All of the tools are preconfigured with my preferences, such as the right wallpaper, color scheme, keyboard shortcuts and fonts.

The actual VMs are then defined with setup scripts of their own on top of the standard layers. So, the VM I use to author this post has nothing else but [Hugo](https://gohugo.io/) installation defined in its script. As another example, I defined a VM to complete an online course. Since the course made use of Java-based tools I specified that JDK should be installed.

Scripting so much of the setup requires a slight mindset change. Anytime I'd like to tweak or change something in the environment (say, shell settings)
I need to consider whether to update the corresponding scripts. The beauty is that the setup lives on as configuration and is made apparent. No more fear that something was left behind after an upgrade!

The provisioning script for the VM I'm writing this post contains the following:

{{< highlight bash >}}
AS="/usr/bin/sudo -u sergey"

# install hugo
pacman -S --noconfirm hugo

# check out repository
echo '==> Checking out repository'
cd /home/sergey
$AS /usr/bin/git clone git@github.com:drseergio/drseergio.github.com.git hugoblog
cd /home/sergey/hugoblog
$AS git checkout source
$AS git worktree add -B master public origin/master

# Reboot!
echo '==> Rebooting!'
/usr/bin/reboot
{{< /highlight >}}

Here's the complete Vagrantfile for the blogging VM:

{{< highlight ruby >}}
Vagrant.configure("2") do |config|
  variables = {
    "EMAIL" => "sergey@pisarenko.net",
    "FULL_NAME" => "Sergey Pisarenko"
  }

  config.vm.box = "arch-base"

  config.vm.hostname = "hugoblog.bethania"

  config.vm.synced_folder 'C:\Users\drsee\UbuntuShared', "/shared"

  config.vm.network "public_network", :bridge => 'Wireless LAN adapter Wi-Fi', :mac => "XXX" # mac has been edited out

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Hugoblog 18.02"

    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
 
    # Customize the amount of memory on the VM:
    vb.memory = "1024"

    # EFI boot
    vb.customize ["modifyvm", :id, "--firmware", "efi64"]

    # disable audio
    vb.customize ["modifyvm", :id, "--audio", "none"]

    # better video
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    vb.customize ["modifyvm", :id, "--vram", "128"]

    # integration with desktop
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]

    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # note how the layers are specified below
  config.vm.provision "file", source: "../../configs", destination: "/tmp/configs"

  config.vm.provision "file", source: "../../wallpapers", destination: "/tmp/wallpapers"

  config.vm.provision "shell", path: "../../layers/cli-setup.sh", env: variables

  config.vm.provision "shell", path: "../../layers/xorg-setup.sh", env: variables

  config.vm.provision "shell", path: "hugoblog-setup.sh", env: variables
end
{{< /highlight >}}

Once all the scripts are in place, getting a complete VM up and running is as simple as:
```
$ vagrant up
```
The VM can then be used in Virtualbox just like a normal VM until it's no longer necessary:
```
$ vagrant destroy  # ...and it's gone!
```

## Closing words

I've been trialing the solution for several weeks now and using this approach for everything but my full-time work. Though there are few minor things to iron out, like shell preferences and environment variables, I'm deeply satisfied with the result! Getting a new machine is just a matter of running a command and then preparing a cup of tea. By the time I get back with a hot ☕ the VM is ready and booted.

The best part is that this also allows me provision physical machines. I can build VM images, test them locally in Virtualbox and then transfer them to physical drives and boot them. Maybe I'd need to install an additional module or two (say, nvidia binary driver) but otherwise it'll work great.

I have uploaded all the configuration files on my github account [https://github.com/pisarenko-net/arch-packer-vagrant](https://github.com/pisarenko-net/arch-packer-vagrant). The configurations are customized to my needs (e.g. include user "sergey") but could serve as a good starting point.