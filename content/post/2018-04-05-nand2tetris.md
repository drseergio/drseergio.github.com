---
title: "From NAND to Game of Life"
subtitle: "Build a computer system from scratch"
date: 2018-04-05T19:17:26+02:00
tags: []
draft: false
categories: [pro]
---

Few weeks ago I finished an online course that deserves an honorable mention. The course is called [Nand2Tetris](http://nand2tetris.org/) and the goal of the course is to develop a computer from scratch, starting with primitive logic gates all the way up to a high-level application written in a custom object-oriented programming language. By the way, I chose to implement a Game of Life simulation.

It's an outstanding well thought-through course. It has taken the authors six years to develop and it shows. The course is completely self-contained and the duration is roughly two months for both parts (assuming a full-time job, high degree of motivation and roughly 6-10 hours per week). Part one is about building the hardware using NAND gates in various constellations. You get to develop the CPU, including ALU and memory chips. The end result is a completely functional 8-bit system. The second part is about building the software stack on top of it, including an assembler, a virtual machine and, finally, a compiler. Obviously, the course doesn't cover every possible detail but as a student you get hands-on experience building the whole thing.

Before taking this course I've never studied computer architecture, compilers or computer language design, except for an occasional ad-hoc book. Thanks to the course I now have an appreciation for the clever machine design and better intuition for future work. Without strong fundamentals it is difficult to reason about performance. Knowing fundamentals also increases confidence as previously inaccessible systems become demystified and come within reach. This kind of knowledge is empowering and motivating. I was so excited during these two months that I've used every spare moment to progress further, going as far as coding during commutes. Normally on the go I can't even imagine opening a laptop!

Working on various parts of a computer system made me practically realize how important the concept of abstraction really is. When working in an object-oriented programming language it is easy to get wishy-washy defining interfaces and boundaries. With this course I've seen that abstractions are very real and extremely important. It's nearly impossible to develop any useful application if it's necessary to keep every system layer in head. Working at one layer at a time is liberating and effective. You build the stack one step at a time and you only care about fulfilling a certain API, be that a set of CPU instructions or a programming language syntax. This lesson was delivered just at the right time as I find myself currently building a system that spans multiple architectural layers.

Another useful realization is that compilers and programming languages are glorified text processing systems. I apologize in advance to all researchers and engineers as there's surely lots of nuances and improvements yet conceptually what compilers do is take source code, tokenize it, make sure the code follows the syntax and then translate the code to assembly (or virtual machine instructions) using predefined transformations. Again, a rough simplification but at the same time liberating and empowering one.

Studying and continued learning is important to me. Just as I love movement and sports I can't imagine taking a long break from learning. I realize I don't even do it for any particular purpose or goal. I am grateful high-quality online courses exist and I look forward to discovering more of these gems.