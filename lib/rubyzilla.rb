require 'xmlrpc/client'

Dir.glob(File.join(File.dirname(__FILE__), 'rubyzilla/*.rb')).each {|f| require f}


module Rubyzilla
  class Bugzilla
    
    def initialize server
      @@server = XMLRPC::Client.new2(server)
      @@logged_in = false
    end
    
    def self.server
      @@server
    end
    
    def self.logged_in?
      @@logged_in
    end
    
    def login login, password
      result = @@server.call("User.login", {
        :login => login.chomp, :password => password.chomp, 
        :remember => 1
      })
        
      @id = result['id']
      
      # Workaround for Bugzilla's broken cookies.
      if @@server.cookie =~ /Bugzilla_logincookie=([^;]+)/
        @@server.cookie = 
          "Bugzilla_login=#{@id}; Bugzilla_logincookie=#{$1}"
        @@logged_in = true
      end
      
      return @@logged_in
    end
    
    def bug id=nil
      return Bug.new(id)
    end
    
    def product id=nil
      return Product.new(id)
    end
  end
end