---
title: "Voxxed Days Zurich 2018"
date: 2018-03-09T19:34:43+01:00
tags: []
draft: false
categories: [pro]
---

{{%img class="center noborder" src="/images/voxxed_days.jpg" %}}

Yesterday I've attended a developer's conference in Zurich. It's called Voxxed Days Zurich and it's held at an alluringly convenient venue - the SihlCity cinema. This year I've attended Voxxed Days for the first time.

<!--more-->

There were several outstanding talks with valuable perspectives. Plus, I've had a chance to socialize with a couple of former colleagues and meet a couple of new faces. Out of the all talks that I've attended a couple stood out, for one reason or another.

## Move slow and mend things

The conference keynote's message was that the we're often measuring and focusing on the wrong things. Speed is not velocity. Velocity has direction while speed doesn't. One could be going nowhere very fast.

Software projects are managed based on false assumptions -- that there are economies of scale but the prohibitive overhead of communication is forgotten. We often repeat that communication is important but that's true up to a point. In a place where everyone talks to everyone no actual progress can be made -- all the time is taken by meetings. I joined a start-up last year at a point where it began transforming into a middle-sized company and it's insightful to observe how the communication patterns change and develop. In the past I used to believe that more communication is always better but cohesive teams function like cohesive software systems: communication is localized, where it's the fastest and least expensive.

The other sore point of project management is measurement of progress. All too often projects are measured not by delivery of tangible value or functionality but on the utilization of developers or accuracy of estimates. What does it mean to have achieved some amount of story points? Just that someone was utilized to the fullest and there was no slack. Yet knowledge work is not factory work so we're possibly restricting the creative flow by having a false sense of certainty. Slack and idle time are great for innovation.

Many companies claim to focus on diversity and it remains a challenge. It has been shown that diverse teams perform better. Yet achieving diversity in practice isn't easy. Just like my colleagues, I've been taking an active role in interviewing and the hiring process. In a growing company that's significant effort. What I'm seeing is that it's maddeningly hard to combine diversity goals with the company culture and performance goals. It's borderline impossible to know how would a particular person fit into the team. I believe there's no way around some sort of trial and error. Plus, an understanding that teams should consists of differing profiles, even if the job description stays the same for everyone.

Finally, I found it refreshing that agile and iterative software methologies date back to 1968. Already back then scientists realized the complex nature of software. It was understood that software design needs to change and that revision is unavoidable.

## Kafka

Kafka consists of several key components and solves distributed computing and data analysis challenges. At its core, Kafka is a distributed log storage. The kind you can append to but never delete from. Consumers could track the log and process new data as it is appended to the log. In one way this appears similar to a queue system, like RabbitMQ. But the big difference is that it's not possible to delete anything from the log -- the data cannot be changed. An illusion of the queue can be maintained as long as the consumers track their position in the log. But one could easily restart from an arbitrary position.

The biggest value proposition are the systems on top of the distributed log. One could design highly robust data processing applications and use Kafka as kind of a nervous system. Streaming data analytics architectures are currently trending and they solve real issues of the previous generation (which is something along the lines of [Lambda architecture](http://lambda-architecture.net/).

Together with a team, I'm currently building an analytics system for a rapidly growing company. We're faced with challenges and difficult requirements, like high performance, real-timeness and preservation of historic values. While we've started with a tightly-scoped MVP, we'll eventually use something along the lines of Kafka and that's why I often find myself thinking about possible solutions. The solution space is vast and there are hundreds of options.

## DROP database

The presenter of this talk was dressed as a wizard and, while his delivery format appeared comical and entertaining, his message really struck a chord with me. In the age of cheap RAM (my laptop has 48GB) using application servers, databases and persistence frameworks isn't optimal. For many uses cases it's a big waste of resources and a performance hindrance.

The talk presented a hypothetical multiverse. In one universe, a team of developers built a solution using Java in-memory data structures and a simple file-system based log. In the other, the team used a relational database with a persistence framework on top of it. The performance differences were ridiculous, with the native solution offering a 10-15x performance advantage.

I'm glad the era of application servers, XML and databases is eventually coming to an end. Not that some of those technologies don't deserve a place. It's just that every tool has its use. There are many systems where a complexity of a database offers no advantages, just disadvantages. Certain applications, when designed properly, can run on a single laptop and still service lots of requests.

## Quantum computing

I keep stumbling upon short videos that explain what quantum computing is. The popular explanations focus on the nature of qubit states and how qubits differ from the classical computer bits. Conceptually, it is not hard to comprehend that qubits can be in different states and that their state is kind of determined by probability density functions. What is difficult to understand (besides the physics, of course) is how to practically make use of such machinery.

Thanks to this talk I realized that quantum computers consist of simple logic gates, just like modern general-purpose computers. Some examples of such gates: Hadamard gate (H), Pauli-X gate, Pauli-Y gate, Ising gate (XX), etc. Modern computers make use of logical gates XOR, AND, NAND, OR, etc. The situation of not knowing how to make use of the new gates is nothing unusual! We already had that problem in the last century -- I bet we didn't exactly know what to do with the primitive gates. Over time, we came up with computational models, computer architectures and impressive applications. Nobody could imagine that something like modern systems could ever exist.

---

Visiting conferences is new habit for me. I'm seeing them as a great opportunity to get fresh insight and exchange ideas with other practitioning software engineers.


