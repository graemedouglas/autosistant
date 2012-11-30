autosistant
===========

A research project aimed at building an automated sales assistant.

System Summary
--------------

The system attempts to help online shoppers buy items from an online store by
having a directed conversation with the user.  The user interacts with the
system via a webpage where the user can type in a message to be sent to the
system.  The system gets the message, analyses it, and returns an approriate
message when complete.

The system's message analyses begins by splitting the input message into
distint words.  It will then attempt to find any words that indicate actions,
also called tasks, that the system must complete.  When such a word is found,
the system adds the task to a task queue.  This queue is always kept sorted
based on task priority.  If the system has no tasks to complete and
the most recent message processed does not exactly tell the system what it
needs to do, then the system will attempt to suggest what the user might have
meant by measuring edit distance of each input word with each task determining
word.  If the system has some number of tasks it is managing, it will treat
all words not mapped to actions as input for the task it will complete next.

Once the system has at least one task to complete, on each conversation turn,
the system attempts at least one task on the queue.  This may lead to task
completion and then task removal and/or the adding of further tasks to
complete based on user input.  Tasks include product identification,
adding identified products to the order, placing an order, suspending a
session, and resuming a session.

Additionally, there is a system administration page.  This allows retailers
to modify the system to meet their needs.  Specifically, administrators can
configure system settings such as the company name, identification questions,
answers to identification questions for specific products, and which words
map to the various system actions.  Additionally, if the system administrator
has knowledge of the relational model, the system's identification path
and order process can be modified.  Future plans to implement this
configuration in a more user-friendly way are a possibility (post-project).

A+ Features
-----------

1.	### Smooth Converstation

The conversation should not feel overly forced and should allow the user
to enter relatively natural sentences as the main form of interaction
with the system.  The goal is to avoid clunky user interace in favour
of dialect.  There are some cases where this is not desirable, such
as choosing products from a list.  In such cases, a mixed syntax is used.
For instance, users may choose items from a product list by entering a system
given identifier, optionally prefixed by a quantity.  To see this in action,
type
	
	"buy"

followed by

	"list"

and enter
	
	"I'd like 1 p0, a p1, and 3 p3"

when prompted in a fresh converstaion to see this mixed approach.

Another aspect of this is to random system behaviour.  The system will
choose one of a set number of random canned phrases when it has a choice.
Additionally, the system will not always ask identification questions in
the same order (though the system can be configured to ask especially
important questions in a given order everytime, as necessary).  Again,
identification questions will be asked in a random order.

2.	### System Configurability

The system, as mentioned before, is configurable to meet different retailer
needs.  I originally planned to make the words that map to actions
configurable, but then also added easy product-question answer configuration,
as well as sytem options, and also basic identification question configuration. 

3.	### Deep Domain Knowledge

The system manages a list of over 70 products as part of the provided
example.  All of these products (except one!) have been configured to be
identifiable.  Adding more products is simply a matter of adding more items
to the database; in other words, domain knowledge is completely scalable!


Additional Features
-------------------
<ol>
<li>
### Flexible Conciseness

The system should be able to handle extremely verbose or extremely terse
input.  This is acheived by using the word mapping model described previously.
</li>
<li>
### Easy Administration

I really wanted to make the system adminstriation to be as simple as possible
given the time I had to develop it.  Making the configuration a webpage with
a simple UI acheives this goal.
</li>
<li>
### Suggestion Prompting

As mentioned previously, the system will attempt to suggest possible
action words if the user's message does not contain any action words and
the system has no tasks to complete.  This is done using edit distance
heuristics.
</li>
<li>
### Heuristic Identifier Matching

The system uses a longest-common-subsequence algorithm to match potential
identifiers with system-stored answers to identifying questions.  It is
highly effective for fuzzy matching user input.
</li>
<li>
### Help Action

The system has a basic help action: it will list out the possible ways of
triggering different actions.  It is meant to give users a basic way
getting started using the system.
</li>
<li>
### Automatic Question Elimination

The system will automatically elminate questions that no longer make sense
to ask or will not be helpful in identifying products.  If all remaining
products are for a 1992 Honda's, then it makes no sense to ask about the
vehicle make or production year.

Furthermore, if the set of products cannot be further reduced, it will
atuomatically list the products so that the user can choose those that they
want to buy.
</li>
<li>
### Session Suspension and Resumation

A user may suspend a session and return to the session at a later time.
This feature is accessible by, at any time, typing

	"I'd like to suspend my session for now."

The system will print out a UUID.  At a later time, you may then say something
along the lines of

	"I'd like to resume my previous session with identification <UUID>"

and the system will automatically resume the session.
</li>

Execution Instructions
----------------------

GRAEME NEEDS TO WRITE THIS!

System Installation Instructions
--------------------------------

GRAEME NEEDS TO WRITE THIS!

Source Files
------------

GRAEME NEEDS TO WRITE THIS!

Known Issues
------------

GRAEME NEEDS TO WRITE THIS!

License Information
-------------------

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
