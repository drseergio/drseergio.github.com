---
layout: post
title: "The Kata of Code"
date: 2016-06-12 15:28
comments: true
categories: tech
---

A fancy word makes even the most mundane things sound legitimate. Enter 'kata' -- a fancy way of saying that one does something mundane, regularly. Originally, the Japanese word 'kata' stands for a very specific kind of practice in traditional arts. But in the programming world it's synonymous with a repetitive coding practice. I have no opinion in the linguistic department but I believe the practice might have some substance. Let me rewind a little bit.

Exactly one year ago I [left a wonderful job in one of the best places to work](/blog/2015/06/16/why-i-have-quit-an-awesome-job/) on this planet. With such a drastic move there's a multitude of reasons. One of the major ones is my ambition to become an excellent software engineer and steer away from the technical support role I had so far pursued.

The first obstacle on the way are the well-known and sometimes wacky software interviews that most respectable companies seem to rely on for choosing among candidates. To prepare myself for the challenge I devised a multi-month plan. About 3 months ago, as I was done with another full-time endeavour, I put the plan through its paces. In this article I'll do my best to explain the first step of the plan -- the study and practice of algorithms and data-structures.

It's not like I've never studied algorithms. In fact, I hold a computer science degree and have completed several excellent online algorithm-focused courses with top marks ([Algorithms Part I](https://www.coursera.org/course/algs4partI), [Algorithms Part II](https://www.coursera.org/course/algs4partII)). But annoyingly if you had asked me to implement a path-finding algorithm or even an O(N*LogN) sorting algorithm I would have struggled without referring to technical books or articles. Should you have asked the same question straight after I had just completed the courses I would have absolutely no issues. From a limited personal survey of fellow engineers it is a very common situation. Few keep algorithms in their heads.

Clearly, without an excellent understanding of algorithms passing a coding interview is unlikely. Besides, algorithms and data structures are the cornerstones of computer science and software. Without the understanding of basic structures it's not possible to solve most of the coding challenges. So I dedicated the first month of preparation to the study of algorithms.

However, as I've already learned, the chosen method of study is critical. It's all to easy to complete a course or a book and then forget everything few weeks after. It is also not sufficient to merely browse through a book or a bunch of articles. Superflous reading creates a perilous illusion of understanding. It is imperative to work through. That's why going through one algorithms book takes a month of full-time effort and not an afternoon. I also emphasize that I had completed algorithm courses before starting this effort. Otherwise, it would make sense to study through the online courses mentioned above first. It would also significantly lengthen the plan.

As there are many more algorithms than the time available to me I had to optimize. It makes little sense to study the most esoteric and domain-specific algorithms for the purpose of preparing for software interviews. I made a survey of interview-related Q&As and websites and came up with the following initial list of algorithms and data structures (in no particular order):

	* Stack/Queue (based on LinkedList)
	* Selection Sort
	* SeparateChainingHashST
	* LSD/MSD sort (Radix)
	* Graph/Digraph/WeightedGraph
	* Edge/EdgeWeightedGraph
	* DFS/BFS
	* Binary Search
	* Weighted Quick Union
	* Insertion Sort
	* Shell Sort
	* DFSPaths/BFSPaths
	* Cycle detection in undirected graph
	* Connected Components with DFS in undirected graph
	* Bipartite check in undirected graph (two color)
	* Merge Sort
	* Bottom-up Merge Sort
	* Quicksort
	* 3-way Quicksort
	* CountSort
	* Min/MaxPQ
	* Heapsort
	* BST
	* Red-black BST
	* LinearProbingHashST
	* Cycle detection in directed graph
	* DFS order and Topological sort
	* Kosaraju-Sharir Strong Connected Components in directed graph
	* Kruskal MST
	* Prim MST
	* Dijkstra SP
	* Acyclic SP
	* Bellman-Ford SP
	* Knuth-Morris-Prath search
	* Boyer-Moore search

It is debatable if some of the algorithms in this list are already too complex for general software engineering interviews (knowledge of esoteric algorithms might be required for more senior or specialized roles). In fact, as practice went by I added a few additional ones and removed a few.

The book I chose for my study is "[Algorithms, 4th edition](https://www.amazon.com/Algorithms-4th-Robert-Sedgewick/dp/032157351X)" from Robert Sedgewick at Princeton University. It's written by the same professor that teaches the corresponding online courses. What sets it apart from other famous algorithm texts is the focus on visually illustrating algorithms and doing algorithm-tracing exercises. Working through an algorithm on paper and tracing all the steps helps to grasp what the algorithm really does. Through these exercises I uncovered that my mental models for some of the algorithms were wrong. The other huge benefit of this book is a [complementary codesite](http://algs4.cs.princeton.edu/) with lots of high-quality and clearly-written implementations of algorithms in Java.

My daily routine consisted of reading about one topic and related algorithms and then trying to re-implement the algorithms myself. As soon as I stumbled I looked-up the text. The complementary code is extremely readable. The implementations may lack some of the fanciest and trickiest optimizations but are invaluable tools for learning. Once I implemented the code I erased and started from scratch, testing thoroughness of my understanding.

As the days went by and I progressed further I felt that I no longer remembered the details of algorithms I had already worked-through. That's when I decided to introduce additional regular algorithm coding practice -- katas. I grouped some of the algorithms together. Then during each practice session I would implement algorithms and data-structures from the top of my head, copying only test cases from the reference implementation. At times I would get stuck. In those moments I learned a little bit more about each algorithm. Often, I would get confused and need to look-up the reference implementation. Next time, though, the practice would become easier and more automatic. Katas keep the algorithm knowledge functional and fresh. Furthermore, being able to implement some of the tricky algorithms from the top of my head on a napkin increases confidence which may sometimes shake under the many stresses of interviews. Finally, being able to implement many algorithms quickly pays off in coding competitions.

I don't know if the original katas are canonical. My coding katas are certainly not. They evolve and change with time. At some point easier algorithms and data-structures become trivial and it no longer makes sense to practice them. I don't practice writing a stack/queue anymore. Sometimes I realize how similar few algorithms are so I leave one of them out. Many graph problems reduce to DFS. Occasionally I study through new algorithms and add them to katas. For example, I've recently added SkipList and SuffixArray. I also group algorithms so that each kata is of similar size. At the moment I have [5 katas in my repertoire](https://github.com/drseergio/practice/tree/master/katas). It takes about 30-60 minutes to complete each one. I aim to complete all of the katas once a week -- on average less than one kata per day. I'm also timing my practice now to see how long each kata takes.

**Here's a distilled version of the algorithm study plan (~1 month of full-time effort)**:

 1. List algorithms/data-structures you need to learn deeply. When in doubt leave it out. Make it as short as feasible. Can always add more later.
 2. Choose an algorithms text. I recommend ["Algorithms, 4th edition" by Robert Sedgewick](https://www.amazon.com/Algorithms-4th-Robert-Sedgewick/dp/032157351X).
 3. Schedule sufficient time each day to read the text and implement algorithms by hand. Keep premature enthusiasm at hand and keep the workload manageable. There's a reason it takes a month.
 4. Collect algorithm implementations and group them into katas.
 5. Regularly perform katas by reimplementing algorithms.
 6. Revise katas, remove trivial algorithms and add new ones as you see fit.
 7. Repeat 6, 7.

I'd like to believe that this study of algorithms and practice of katas will pay off. It is hard to say, taking into account the many factors that affect a hiring decision. Doing a comprehensive study like this won't guarantee success but doing nothing almost certainly guarantees failure. The study of algorithms is just the first interview preparation step. I've introduced katas as means to not forget what I've just learned. But as I've practiced and grown my personal collection I see myself continuing with katas.

I will add links here once I write about further steps of my software interview preparation plan.