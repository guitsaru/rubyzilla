require 'rubyzilla'

module Rubyzilla
  class Bug
    attr_accessor :bug_id, :product_id, :component_id, :summary, :version
    attr_accessor :op_sys, :platform
    
    def initialize id
      result = Bugzilla.server.call("Bug.get_bugs", {:ids => [id]})
      
      @product_id   = result["bugs"][0]["internals"]["product_id"]
      @bug_id       = result["bugs"][0]["id"]
      @component_id = result["bugs"][0]["internals"]["component_id"]
      @summary      = result["bugs"][0]["summary"]
      @version      = result["bugs"][0]["internals"]["version"]
      @op_sys       = result["bugs"][0]["op_sys"]
      @platform     = result["bugs"][0]["platform"]
      
      return self
    end
    
    def product
      Product.new(@product_id)
    end
  end
end