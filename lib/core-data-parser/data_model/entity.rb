class CoreDataParser::DataModel
  class Entity
    attr_reader :name, :attributes, :relationships

    def initialize(entity)
      raise ArgumentError unless ::Nokogiri::XML::Element === entity

      @name = entity['name']
      @attributes = entity.xpath('attribute').collect{|element| Attribute.new(element)}
      @relationships = entity.xpath('relationship').collect{|element| Relationship.new(element)}
    end

    def to_s
      @name
    end
    
    private
    

    def underscore_name(name)
      name.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

  end
end
