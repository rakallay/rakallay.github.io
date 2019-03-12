---
title: "Software Cohesion"
date: 2018-01-07
draft: false
publishdate: 2018-01-07
---

# Cohesion
In 2013 or 2014 I was in a training class and the instructor brought up the term cohesion when describing some code the class was analyzing.  This was the first time I had heard of the term cohesion being applied to a piece of code and the instructor did not spend much time on the topic.  As a way of cementing the idea in my mind, I wanted to share some things I’ve read and learned regarding cohesion in software.

## What is it?
According to Merriam Webster[1] cohesion is

> 1: the act or state of sticking together tightly; especially : unity &lt;the lack of cohesion in the Party — The Times Literary Supplement (London)&gt; &lt;cohesion among soldiers in a unit&gt;
>
> 2: union between similar plant parts or organs
>
> 3: molecular attraction by which the particles of a body are united throughout the mass

So, if we use the dictionary definition of cohesion, we could take that it means that cohesive software sticks together or cohesive software combines together similar parts of code into one module or group.

There are some decent answers on stackoverflow as to what cohesion is [[2]](http://stackoverflow.com/questions/3085285/cohesion-coupling) but I couldn’t find anything that goes into extensive detail.   I did watch a video by Uncle Bob regarding Component Cohesion[[3]](https://cleancoders.com/episode/clean-code-episode-16/show), but that didn’t go the level of software cohesion that I was looking for.  I wanted to share some notes I’ve taken from a 1979 book titled “Structured Design – Fundamentals of a Discipline of Computer Program and Systems Design”[[4]](https://www.amazon.com/Structured-Design-Fundamentals-Discipline-Computer/dp/0138544719).  This book has an entire 40 pages(chapter 7) dedicated to talking about cohesion between software modules!

With the book being published in 1979, it is a little tough to digest some of the coding examples, but I found myself discovering statements that are eerily similar to statements that software engineers continue to make today.  Here are a few examples

When referring to “coincidental cohesion”:

> “Modules of this type have a propensity to appear at an early point in classroom introductions to “subroutinization”.  The practice was prevalent (and sometimes justified) in the early 1960’s, when the available computers tended to have severe memory limitations.  Unfortunately, even in today’s world of multi-megabyte computers, some designers persist in developing  coincidentally cohesive modules in attempt to save memory.”

When discussing new trends in the software industry –

> “In the past few years, the computer industry has been revolutionized by a number of new philosophies and techniques.  One of the most popular of these techniques, structured programming, in some cases has led to order-of magnitude improvements in productivity, reliability, and maintenance costs associated with computer systems.
>
> More recently, though, there has been a recognition that perfect structuring of GOTO-less code may be of little value if the basic design of the program or system is unsound.  Indeed, there are a number of well-known case studies, including the now famed IBM system for The New York Times, in which maintenance problems have persisted despite the use of top-down structured programming techniques.  In virtually all of these cases, the problems were due to misunderstanding of some fundamental design techniques.”

This quote is similar to what I’m sure has been said about object oriented programming and functional programming.  I’d imagine for object oriented programming you can replace “GOTO-less” with “free of procedural style”.  For functional programming replace “GOTO-less” with “not object oriented or procedural”.    The end takeaway from that statement is that there is no “silver bullet”[[5]](https://en.wikipedia.org/wiki/No_Silver_Bullet) programming style which can withstand bad design.

## Types of Cohesion

In chapter 7, the authors describe seven different levels of cohesion

- coincidental
- logical
- temporal
- procedural
- communicational
- sequential
- functional

The goal of this blog post is to describe these levels of cohesion.  In a future blog post or series of posts I’ll try to give a code example of what I think a program with this type of cohesion would look like in Java or another current language.

All of the quoted material in the sections that follow are taken directly from the Structured Design book.

### Coincidental Cohesion
> “Coincidental cohesion occurs when there is little or no constructive relationship among the elements of a module;”

The author gives an example where a programmer might put three lines of repeated code into its own method.  These three lines might not be related to each other at all, but the programmer thought that since they are repeated they must belong in the same module.  I’ve seen this in code where a developer put data access, logging, and other exception handling in a single reusable method just because they were commonly repeated throughout the code.  The author stresses that this is not necessarily a bad thing, but if the need to insert some other code in between those three lines occurs for only one scenario, then having that reusable method used all over the code base makes it more difficult to change than it should be.

> “If the duplicated sequences of code…are each coincidentally associated or low in cohesion, a better design might result if they are physically duplicated in the code…by actually writing the code two times, three times, or as many times as necessary in the code”.

This quote reminds me of a blog post by Sandi Metz[[6]](https://www.sandimetz.com/blog/2016/1/20/the-wrong-abstraction) where she makes that case that “duplication is far cheaper than the wrong abstraction”.  So basically, it is better to have some duplicated code rather than abstracting out some repeated code into a separate class/method that doesn’t make sense in the long run.  Recovering from a poor design decision is harder than cleaning up duplicated code.

The author states that the most common place to see coincidental cohesion is in startup and termination logic.  This made me think back to my teams code where we might have coincidentally cohesive code and I think we for sure have coincidentally cohesive code in our startup logic for one of our services.

### Logical Cohesion
> “The elements of a module are logically associated if one can think of them as falling into the same logical class of similar or related functions — that is, ones that would logically be thought of together.”

The author gives a few examples logically cohesive modules

- All input operations put into one module
- All validation of incoming data “regardless of source, type, or use.”
- A general purpose error-routine “depending on the specific type of error, it will print one of several different error messages.
Logical cohesion is considered a little stronger than coincidental cohesion by the authors.

### Temporal Cohesion
> “Temporal cohesion means that all occurrences of all elements of processing in a collection occur within the same limited period of time during the execution of the system.”

Temporal cohesion is considered to be a very weak form of cohesion, but it is slightly stronger than logical cohesion, and far stronger than coincidental cohesion.

Thinking about some of the code that my team writes, I can pick several classes and functions that have a large amount of temporal cohesion.  There are times when it is tempting to put a bug fix in with another piece of code because it makes sense from a timing perspective, but doing so will make it very difficult to modify that code with confidence in the future.

### Procedural Cohesion
To paraphrase the author “Procedural cohesion occurs when code is put together in a loop, decision process, or linear sequence of steps.  This differs from temporal cohesion in that temporal cohesion does not involve pieces of code which have a linear sequence of steps.  The ordering in a temporally cohesive piece of code is not important.”

> “to say that a module achieves only procedural cohesion, the elements of processing would have to be elements of some iteration, decision, or sequencing operation — but not also be elements of any stronger associative principles discussed in subsequent sections of this chapter.”

Temporally cohesive elements do not have to execute in a particular order while procedurally cohesive elements do need to execute in a particular order in order to be considered procedurally cohesive.

> “Procedural cohesion associates processing elements on the basis of their procedural or algorithmic relationships.”
>
> “The general point is that procedural cohesion often cuts across functional lines”

The authors stress that procedural cohesion is not necessarily bad if combined with other types of cohesion.

### Communicational Cohesion
> “Communicational cohesion is the lowest level at which we encounter a relationship among processing elements which is intrinsically problem-dependent.  To say that a set of processing elements is communicationally associated means that all of the elements operate upon the same input data set and/or produce the same output data.”

It is not the strongest form of cohesion, but it “is sufficiently high as to be generally acceptable in the absence of strong counterarguments or lacking and identifiable alternative structure with higher cohesion”.

> “Often, it is the result of thinking in terms of all the things that can be done with a given item or piece of data once it is obtained or generated, or, on the other side, in terms of all the things that must be done to create a given result, say a detailed line in a report.”

The author states that communicational cohesion between both the input and output data is somewhat weaker than between just the input data and the output data.

If some of the methods in a module or class share the same inputs and outputs those are likely communicationally associated.  If other methods in that same class or module have completely different inputs and outputs that might be an indicator that you’ve included those methods in your class due to logical cohesion rather than communicational cohesion.

The author makes the case that mixing groups of methods in the same module which are communicationally cohesive as a group with only each other but logically cohesive with each other may lead to timing issues with shared data or issues with the sequencing of the operations.  An example given is a module that handles all operations related to a file (opening, closing, writing, rewinding, backspacing, etc).  The opening, closing and writing are communicationally cohesive with each other, but not really with the rewinding and backspacing.  Having those all be a part of the same module may lead to the issues the author described.

### Sequential Cohesion
Sequential cohesion is the second strongest form of cohesion.  The author states that sequential cohesion is a type of cohesion ” in which the output data (or results) from one processing element serve as input data for the next processing element.  In terms of the data flow of a problem, sequential cohesion combines a linear chain of successive (sequential) transformations of data.”  The author mentions that sequential cohesion is stronger than communicational cohesion based on some experiments he performed in 1968 and 1969.

Identifying sequential cohesion can be done by drawing out the data flow graph for a problem.  “The data flow graph for a problem will make it obvious that sequential cohesion results in fewer, simpler intermodular relationships”.  I take this to mean that if you have modules dedicated to handling each type of data separately it will lead to less coupling in your system.

The author states that sequential cohesion can potentially suffer from the same weakness as the previously mentioned levels of cohesion: “In attempting to modify the code for one function found in whole or in part in a module, the programmer may find that he is inadvertently modifying, or that he must consider, code for another function that happens to be in the same module.  Similarly, if we find that each module contains only part of a function (as may sometimes be the case with sequentially cohesive modules), then arguments of coupling apply:  In order to understand what one module does, we must understand what another module does – and the second module may contain other processing elements that have nothing to do with the function performed by the first module.”

### Functional Cohesion
The authors consider functional cohesion to be the strongest form of cohesion.  “In a completely functional module, every element of processing is an integral part of, and is essential to, the performance of a single function”.

> “Functional cohesion is whatever is not sequential, communicational, procedural, temporal, logical, or coincidental.”

The author states that the best way to describe functional cohesion is to give some examples.  The easiest things to identify as functionally cohesive are mathematical operations such as calculating a square root, logarithm, or exponential.  If any changes were made to the square root method it would likely change the result of the square root method.

The authors argue that modules which are elementary in nature are likely to be functional in nature.

The authors suggest that one way of identifying functionally cohesive elements is by a process of elimination in which it is shown that the function or module is not one of the other levels of cohesion and then they give some advice to help identifying the type of cohesion for a module.  The authors suggest identifying the functionality of the module in a simple English sentence – ” it should be possible to describe its operation fully in an imperative sentence of simple structure, usually with a single transitive verb and a specific non-plural object.”

The following guidelines are given for identifying the levels of cohesion from the sentence created for the module

- > If the only reasonable way of describing the module’s operation is a compound sentence, or a sentence containing a comma, or a sentence containing more than one verb, then the module is probably less than functional.  It may be sequential, communicational, or logical in terms of cohesion.

- > If the descriptive sentence contains such time-oriented words as “first”, “next”, “after”, “then”, “start”, “step”, “when”, “until”, or “for all” then the module probably has temporal or procedural cohesion; sometimes but less often, such words are indicative of sequential cohesion.

- > If the predicate of the descriptive sentence does not contain a single specific objective following the verb, the module is probably logically cohesive.  Thus, a functional module might be described by “Process a GLOP.”  A logicall bound module might be described by “Process all GLOPS,” or “Do things with GLOPS”.

- > Words such as “initialize”, “clean-up”, and “housekeeping” in the descriptive sentence imply temporal cohesion.

It is key to carefully construct the descriptive sentence.  This will help in identifying the type of cohesion present.

## Measuring Cohesion
The authors stress that any given module will likely contain many of the levels of cohesion mentioned.

> “The smaller processing elements constituting a function are also sequentially, communicationally, procedurally, temporally, or logically associated”

> “Where there is more than one relationship between any pair of processing elements, the highest level of cohesion applies.  This, if module FOO consists of a collection of processing elements, all of which are examples of the same logical class of operations (say, validity checking), but are also all related communicationally in that they check various kinds of validity of one type of item, then FOO is evaluated as having communicational cohesion among all of its elements.”

> “For debugging, maintenance, and modification purposes, a module behaves as if it were ‘only as strong as its weakest link'”.

> “The cohesion of a module is approximately the highest level of cohesion which applicable to all elements of processing in the module.”

> “the lowest three levels are generally indicative of unacceptable partitions”

The authors give what they believe to be the relative strengths of the levels of cohesion, though they admit it is not a scientific measurement.

0 : coincidental

1 : logical

3 : temporal

5 : procedural

7 : communicational

9 : sequential

10 : functional

## Side Effects
There was a little discussion regarding side effects and the impact on cohesion and I wanted to share one quote from the authors regarding

> “Side effects operate as if they marginally lower the cohesion of any module that includes them.”

This an interesting statement because this sounds like a good argument for using a functional style of programming which encourages a reduction of side effects in your program.

## General Implementation Details
Logically grouping elements may cause the developer to share code between the logically cohesive elements, thus causing it to be harder to make changes in the elements.

The authors discourage creating one module which performs all of the input validation and transformation of input for a program.  They say that this will likely cause scenarios where if new validations/edits are needed or a modification of how validation is performed is needed, a change will also likely be needed in the main part of the program and other parts of the program.  They suggest that there is a stronger level of cohesion between the elements which validate/edit a piece of data and the elements which process the data and take action on it.  My takeaway was that it would be better to separate the program into multiple modules where each module performs validation/editing and processing of one specific item or group of very similar items.

## Summary
The authors summarize their cohesion chapter by stating

> “From the discussions in this chapter, you should not conclude that all logical modules are bad, nor that editing and validation should always be distributed throughout a system; nor should you attempt to derive any other black-and-white rules of thumb.  High cohesion is not “good”, nor is coincidental cohesion “evil.”  Module cohesion is associated with effective modularity; it has certain predictable effects on transparency, programmaticability, ease of debugging, ease of maintenance, and ease of modification.”

The authors essentially state that sometimes tradeoffs in cohesion are necessary to ensure the program runs efficiently.  “The designer may save design effort, too, since logical and temporal groupings are comparatively easy to identify and describe – while complete functional cohesion may require extensive analysis and study.”

## References

[1] “Cohesion.” Merriam-Webster.com. Merriam-Webster, n.d. Web. 20 Feb. 2017.

[2] [http://stackoverflow.com/questions/3085285/cohesion-coupling](http://stackoverflow.com/questions/3085285/cohesion-coupling)

[3] [https://cleancoders.com/episode/clean-code-episode-16/show](https://cleancoders.com/episode/clean-code-episode-16/show)

[4] [https://www.amazon.com/Structured-Design-Fundamentals-Discipline-Computer/dp/0138544719](https://www.amazon.com/Structured-Design-Fundamentals-Discipline-Computer/dp/0138544719)

[5] [https://en.wikipedia.org/wiki/No_Silver_Bullet](https://en.wikipedia.org/wiki/No_Silver_Bullet)

[6] [https://www.sandimetz.com/blog/2016/1/20/the-wrong-abstraction](https://www.sandimetz.com/blog/2016/1/20/the-wrong-abstraction)