require 'rubyzilla'

bugzilla = Rubyzilla::Bugzilla.new("http://10.211.55.7/bugzilla/xmlrpc.cgi")

bug = bugzilla.bug(5)

puts bug.bug_id
puts bug.product_id
puts bug.component_id
puts bug.summary
puts bug.version
puts bug.op_sys
puts bug.platform
puts bug.product

puts
puts Rubyzilla::Product.list

puts
puts Rubyzilla::Product.new(2).components