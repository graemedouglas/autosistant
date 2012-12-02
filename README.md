autosistant
===========

A research project aimed at building an automated sales assistant.

System Summary
--------------

The system attempts to help online shoppers buy items from an online store by
having a directed conversation with the user.  The user interacts with the
system via a web-page where the user can type in a message to be sent to the
system.  The system gets the message, analyses it, and returns an appropriate
message when complete.

The system's message analyses begins by splitting the input message into
distinct words.  It will then attempt to find any words that indicate actions,
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

### Smooth Conversation

The conversation should not feel overly forced and should allow the user
to enter relatively natural sentences as the main form of interaction
with the system.  The goal is to avoid clunky user interface in favor
of dialect.  There are some cases where this is not desirable, such
as choosing products from a list.  In such cases, a mixed syntax is
used.  For instance, users may choose items from a product list by
entering a system given identifier, optionally prefixed by a quantity.
To see this in action, type

	"buy"

followed by

	"list"

and enter

	"I'd like 1 p0, a p1, and 3 p3"

when prompted in a fresh conversation to see this mixed approach.

Another aspect of this is to random system behavior.  The system will
choose one of a set number of random canned phrases when it has a
choice.  Additionally, the system will not always ask identification
questions in the same order (though the system can be configured to
ask especially important questions in a given order every time, as
necessary).  Again, identification questions will be asked in a
random order.

### System Configurability

The system, as mentioned before, is configurable to meet different
retailer needs.  I originally planned to make the words that map to
actions configurable, but then also added easy product-question answer
configuration, as well as system options, and also basic identification
question configuration. 

### Deep Domain Knowledge

The system manages a list of over 70 products as part of the provided
example.  All of these products (except one!) have been configured to be
identifiable.  Adding more products is simply a matter of adding more
items to the database; in other words, domain knowledge is completely
scalable!


Additional Features
-------------------
### Flexible Conciseness

The system should be able to handle extremely verbose or extremely terse
input.  This is achieved by using the word mapping model described previously.

### Easy Administration

I really wanted to make the system administration to be as simple as possible
given the time I had to develop it.  Making the configuration a web page with
a simple UI achieves this goal.

### Suggestion Prompting

As mentioned previously, the system will attempt to suggest possible
action words if the user's message does not contain any action words and
the system has no tasks to complete.  This is done using edit distance
heuristics.

### Heuristic Identifier Matching

The system uses a longest-common-subsequence algorithm to match potential
identifiers with system-stored answers to identifying questions.  It is
highly effective for fuzzy matching user input.

### Help Action

The system has a basic help action: it will list out the possible ways of
triggering different actions.  It is meant to give users a basic way
getting started using the system.

### Automatic Question Elimination

The system will automatically eliminate questions that no longer make sense
to ask or will not be helpful in identifying products.  If all remaining
products are for a 1992 Honda's, then it makes no sense to ask about the
vehicle make or production year.

Furthermore, if the set of products cannot be further reduced, it will
automatically list the products so that the user can choose those that they
want to buy.

### Session Suspension and Resumption

A user may suspend a session and return to the session at a later time.
This feature is accessible by, at any time, typing

	"I'd like to suspend my session for now."

The system will print out a UUID.  At a later time, you may then say something
along the lines of

	"I'd like to resume my previous session with identification <UUID>"

and the system will automatically resume the session.

### Hot Updating

The system will automatically and safely update any configuration variables
that have been changed by a system administrator, even if a user is
in the middle of a conversation.  This means that the system can be
reconfigured with zero downtime.

System Installation and Execution Instructions
----------------------------------------------

The system has been written and tested using Ruby 1.9.3 and rvm.  Installation
of this software varies from system to system, but packages exist for pretty
much any operating system.  Once this has been done, rubygems must be installed
using rvm

	rvm rubygems current

The system also depends on many gems, which can be installed by

	gem install rack thin sinatra shotgun pony sqlite3

The system requires that a recent version of the SQLite3 database management
system is installed.  This also varies from system to system, but most UNIX
systems come installed with it.

To install the system, simply execute from any bash shell:

	git clone git://github.com/graemedouglas/autosistant.git

The databases for an example system must be setup before running the code.
This can be done by executing in a bash shell:
	
	cd src/sql
	ruby setupexample.rb

Once the system has been installed, the system can be executed by executing,
from the project directory in a bash shell:

	cd src
	ruby autosistant.rb

This will run the software on port 4567.  To access the chat client,
visit:
	
	http://localhost:4567/autosistant

To visit the administration page, visit
	
	http://localhost:4567/autosistant/admin

The administration page requires an Internet connection since it uses Google's
JQueryUI CDN.

Source Files
------------

All source code files are in the src/ directory.  The files are:

*	_autosistant.rb_
	
	This is the main Sinatra application script.  It contains all of the
	websites routes (Sinatra is a routing DSL, after all!) as well as
	some code needed for the various routes.
*	_actions.rb_
	
	This script contains the "task store".  All system tasks are defined
	in this file, within an array.  Some additional methods needed by
	various actions are also defined here.
*	_classes.rb_
	
	Here all object definitions and modifications are defined.  This
	includes modifications to the Array and String classes as well as
	definitions for the Users and Tasks.
*	_config.rb_
	
	This is a file that is required by other files to make some of the
	basic system configuration easily accessible.
*	_sql/config.sql_
	
	This file defines the tables in the configuration database.
*	_sql/products.sql_
	
	This file defines the tables needed to store product information.
*	_sql/userstore.sql_
	
	This file defines the table which stores serialized user session
	objects.
*	_sql/config-example.sql_
	
	In this file, some very basic test data is defined for the
	configuration database.
*	_sql/deep-config.sql_
	
	This file contains more in-depth example data.  If it is used,
	it should be used alongside the deep-products.sql.
*	_sql/product-example.sql_
	
	A shallow example of product data is defined here.
*	_sql/deep-products.sql_
	
	Once again, this file defines a more complete set of product data
	used for my example configuration.
*	_setupexample.rb_
	
	This file will create all the databases necessary for the system,
	and will setup the example as to be marked.  This includes the
	complete data set defined in the deep configuration files.
*	_public/js/admin.js_
	
	This contains all client javascript code needed for completing all
	of the administration features.  This includes validation code and AJAX
	handling functions.  It depends on JQuery.
*	_views/admin.erb_
	
	This is the file containing the templating ruby and HTML code used for
	the administration page.  This file depends on JQuery and JQueryUI.
*	_views/chat.erb_
	
	This is the HTML file for the chat client.
*	_sqlite/config.db_
	
	Once generated, this is the SQLite3 database file for the configuration
	database.
*	_sqlite/product.db_
	
	Once generated, this is the SQLite3 database file for the product
	database.
*	_userstore.db_
	
	Once generated this is the SQLite3 database file for the user session
	database.

As a side note, all documentation exists in _doc/_ within the project
directory.

Known Issues
------------

*	Order process verification isn't as comprehensive as it should be.
	Specifically, when prompted for an expiry year, any 4 digit number
	starting with a 2 is "acceptable".  When prompted for a month, since
	matches are made from the starting of a string, "20" matches to "2"
	and is thus an acceptable answer.  If I had a little more time, I'd
	refactor the code to make it more precise, possibly storing serialized
	verification code for each item instead of a regular expression.
*	Since the system splits up the user's message primarily on spaces,
	getting certain pieces of information, such as addresses, locations,
	and zip codes do not work exactly as intended.  If I had more time,
	I would fix this by returning a flag during any task where we wish
	to not split up the message contentsand handle the input properly.
*	I do not split on periods.  This is so I can handle emails properly.
	Again, a flag for when to not split the input would fix this problem.

License Information
-------------------

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see http://www.gnu.org/licenses/.
