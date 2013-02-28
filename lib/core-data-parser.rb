require 'core-data-parser/data_model'
require 'core-data-parser/version'

module CoreDataParser
  def self.parse(xcdatamodel, prefix=nil)
    model = CoreDataParser::DataModel.new(xcdatamodel)

    model.entities.each do |entity|

      entity.name.slice!(prefix) if prefix && entity.name.start_with?(prefix)

      properties ={}
      
      entity.attributes.each do |attribute|
        next if attribute.transient?

        attribute.name.slice!(prefix) if prefix && attribute.name.start_with?(prefix)

        type = case attribute.type
                when "Integer 16" then :integer
                when "Integer 32" then :integer
                when "Integer 64" then :integer
                when "Float" then :float
                when "Double" then :float
                when "Decimal" then :float
                when "Date" then :datetime
                when "Boolean" then :boolean
                when "Binary" then :bytea
                else :string
               end

        properties[attribute.name.to_sym] = type
      end

      entity.relationships.each do |relationship|
        options = {
          :index => true,
          :null => relationship.optional?
        }

        if not relationship.to_many?
          relationship_name = relationship.name
          relationship_name.slice!(prefix) if prefix && relationship_name.start_with?(prefix)
          properties["#{relationship.name}_id".to_sym] = :integer
        end
      end

      suffix = properties.keys.map{|key| "#{key}:#{properties[key.to_sym]}"}.join(' ')
      puts "bundle exec rails generate model #{entity.name} #{suffix}"
      `bundle exec rails generate model #{entity.name} #{suffix}`

      # After the model has been created we can generate relationships and validatations...
      # entity.relationships.each do |relationship|
      #   options = {:class => Rack::CoreData::Models.const_get(relationship.destination.capitalize)}
      # 
      #   if relationship.to_many?
      #     one_to_many relationship.name.to_sym, options
      #   else
      #     many_to_one relationship.name.to_sym, options
      #   end
      # end
      #
      # klass.send :define_method, :validate do
      #   entity.attributes.each do |attribute|
      #     case attribute.type
      #       when "Integer 16", "Integer 32", "Integer 64"
      #         validates_integer attribute.name
      #       when "Float", "Double", "Decimal"
      #         validates_numeric attribute.name
      #       when "String"
      #         validates_min_length attribute.minimum_value, attribute.name if attribute.minimum_value
      #         validates_max_length attribute.maximum_value, attribute.name if attribute.maximum_value
      #      end
      #   end
      # end
    end
  end
end
