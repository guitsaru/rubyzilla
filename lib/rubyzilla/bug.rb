require 'rubyzilla'

module Rubyzilla
  class Bug
    attr_accessor :id
    
    # Required create parameters 
    attr_accessor :product_id, :component_id, :summary, :version
    attr_accessor :component # String value component for creation
    @product # String value component for creation
    
    # Defaulted create parameters
    attr_accessor :op_sys, :platform, :priority, :severity
    attr_accessor :description
    
    # Optional create parameters
    attr_accessor :alias, :assigned_to, :cc, :qa_contact, :status
    attr_accessor :target_milestone
    
    def initialize id=nil
      unless id.nil?
        result = Bugzilla.server.call("Bug.get_bugs", {:ids => [id]})
        
        @product_id   = result["bugs"][0]["internals"]["product_id"]
        @product      = product
        @id           = result["bugs"][0]["id"]
        @component_id = result["bugs"][0]["internals"]["component_id"]
        @summary      = result["bugs"][0]["summary"]
        @version      = result["bugs"][0]["internals"]["version"]
        @op_sys       = result["bugs"][0]["internals"]["op_sys"]
        @platform     = result["bugs"][0]["internals"]["rep_platform"]
        @priority     = result["bugs"][0]["internals"]["priority"]
        @description  = result["bugs"][0]["internals"]["short_desc"]
        @alias        = result["bugs"][0]["alias"]
        @qa_contact   = result["bugs"][0]["internals"]["qa_contact"]
        @status       = result["bugs"][0]["internals"]["status_whiteboard"]
        @target_milestone = result["bugs"][0]["internals"]["target_milestone"]
        @severity     = result["bugs"][0]["internals"]["bug_severity"]
      end
      return self
    end
    
    def product
      Product.new(@product_id)
    end
    
    def product= _product
      @product_id = _product.id
      @product = _product.name
    end
    
    def create
      if Bugzilla.logged_in?
        parameters = {
          :product => @product,
          :component => @component,
          :summary => @summary || "",
          :version => @version || "unspecified",
          :op_sys => @op_sys || "Windows",
          :platform => @platform || "PC",
          :priority => @priority || "P5",
        }
      
        parameters.merge!({:severity => @severity}) if @severity
        parameters.merge!({:description => @description}) if @description
        parameters.merge!({:alias => @alias}) if @alias && @alias != ""
        parameters.merge!({:assigned_to => @assigned_to}) if @assigned_to
        parameters.merge!({:cc => @cc}) if @cc
        parameters.merge!({:qa_contact => @qa_contact}) if @qa_contact
        parameters.merge!({:status => @status}) if @status
        parameters.merge!({:target_milestone => @target_milestone}) if
          @target_milestone

        result = Bugzilla.server.call("Bug.create", parameters)
        
        @id = result["id"].to_i
      end
      return self
    end
  end
end