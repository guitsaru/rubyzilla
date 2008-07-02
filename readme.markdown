Rubyzilla
=================

Author: [Matt Pruitt](http://github.com/guitsaru) 2008

Synopsis
--------
A ruby API for interfacing with bugzilla

Downloading
-----------
Rubyzilla can be installed through rubygems

    gem sources -a http://gems.github.com # You only have to do this once
    sudo gem install guitsaru-rubyzilla

Source can be downloaded from the rubyzilla [github](http://github.com/guitsaru/rubyzilla) page or can be downloaded from the git repository using:

    git clone git://github.com/guitsaru/rubyzilla.git

Usage
-----
    gem 'guitsaru-rubyzilla'
    require 'rubyzilla'
    
    bugzilla = Rubyzilla::Bugzilla.new(xmlrpc_file_address)
  	bugzilla.login(email, password)

  	# Fetches the bug with an id of 5
  	bug = bugzilla.bug(5)

  	# Creates a new bug
  	new_bug = bugzilla.bug
  	# Fetches the product with an id of 1
  	new_bug.product = bugzilla.product(1)
  	# There is no built in way to handle components, the following command
  	# selects the first available component for this particular product.
  	# You can list available components with
  	# new_but.product.components
  	new_bug.component = new_bug.product.components[0]
  	new_bug.summary = "The program crashes"
  	new_bug.description = 
  		"The program crashes when the user does something incorrectly"
  	# Creates a new bug on the bugzilla server with the given information
  	new_bug.create
  	
License
-------
Rubyzilla is released under the MIT licsnse

Copyright (c) 2008 Matt Pruitt

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.