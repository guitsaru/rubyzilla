require 'xmlrpc/client'
require 'user'
require 'bug'
require 'product'

module Rubyzilla
  class Bugzilla
    attr_accessor :logged_in, :server
    
    def initialize server
      @@server = XMLRPC::Client.new2(server)
    end
    
    def self.server
      @@server
    end
    
    
    def login login, password
      result = bugzilla.server.call("User.login", {
        :login => login.chomp, :password => password.chomp, 
        :remember => 1
      })
        
      @id = result['id']
      
      # Workaround for Bugzilla's broken cookies.
      if bugzilla.server.cookie =~ /Bugzilla_logincookie=([^;]+)/
        bugzilla.server.cookie = 
          "Bugzilla_login=#{@id}; Bugzilla_logincookie=#{$1}"
        @logged_in = true
      end
      
      user = User.new
      user.id = @id
      user.login = login
      user.password = password
      return user
    end
    
    def bug id
      return Bug.new(id)
    end
  end
end

# new_bug_result = bugzilla.server.call("Bug.create", {
#   :product => 'TestProduct', :component => 'TestComponent', 
#   :summary => 'This is a test of xmlrpc', :version => 'unspecified', 
#   :op_sys => "Mac OS", :platform => 'PC'
# })