class CoreDataParser::DataModel
  class Relationship
    attr_reader :name, :destination, :inverse, :deletion_rule, :min_count, :max_count

    def initialize(relationship)
      raise ArgumentError unless ::Nokogiri::XML::Element === relationship

      @name = underscore_name(relationship['name'])
      @destination = underscore_name(relationship['destinationEntity'])
      @inverse = underscore_name(relationship['inverseName'])
      @deletion_rule = relationship['deletionRule'].downcase.to_sym

      @min_count = relationship['minCount'].to_i
      @max_count = relationship['maxCount'].to_i

      @to_many = relationship['toMany'] == "YES"
      @optional = relationship['optional'] == "YES"
      @syncable = relationship['syncable'] == "YES"
    end

    def to_s
      @name
    end

    def to_many?
      !!@to_many
    end

    def to_one?
      !to_many?
    end

    [:optional, :syncable].each do |symbol|
      define_method("#{symbol}?") {!!instance_variable_get(("@#{symbol}").intern)}
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
