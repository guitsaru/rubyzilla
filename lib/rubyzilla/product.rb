module Rubyzilla
  class Product
    attr_accessor :id, :name
    
    def initialize id
      product = Bugzilla.server.call("Product.get_products", {:ids => [id]})
      @id = id
      @name = product["products"][0]["name"]
    end
    
    # accessible, enterable, selectable
    def self.list s="accessible"
      product_list = Array.new
      
      product_ids =
        Bugzilla.server.call("Product.get_#{s}_products")["ids"]
        
      product_ids.map {|id| product_list << Product.new(id)}
      return product_list
    end
    
    def components
      result = Bugzilla.server.call("Bug.legal_values", {
        :field => 'component', :product_id => @id
      })
      return result["values"]
    end
    
    def milestones
      result = Bugzilla.server.call("Bug.legal_values", {
        :field => 'target_milestone', :product_id => @id
      })
      result["values"]
    end
    
    def versions
      result = Bugzilla.server.call("Bug.legal_values", {
        :field => 'version', :product_id => @id
      })
      result["values"]
    end
    
    def to_s
      @name
    end
  end
end