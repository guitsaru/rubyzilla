require 'rubyzilla'

bugzilla = Rubyzilla::Bugzilla.new("http://10.211.55.7/bugzilla/xmlrpc.cgi")

bug = bugzilla.bug(5)

puts bug.id
puts bug.product_id
puts bug.component_id
puts bug.summary
puts bug.version
puts bug.op_sys
puts bug.platform
puts bug.product
puts bug.priority

puts
puts Rubyzilla::Product.list

puts
puts bugzilla.product(2).components

puts
puts bugzilla.product(2).milestones

new_bug = bugzilla.bug
#attr_accessor :product_id, :component_id, :summary, :version

bugzilla.login("matt.pruitt@gmail.com", "secret")

new_bug.product = bugzilla.product(2)
new_bug.component = new_bug.product.components[0]
new_bug.summary = "This was made through rubyzilla."
new_bug.description = "This is a long description, hopefully it shows up below the bug report"
new_bug.create
puts new_bug.id