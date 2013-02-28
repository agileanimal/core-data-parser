require 'core-data-parser'
require 'thor'

module CoreDataParser
  class Command < Thor
    include Thor::Actions
    desc "parse xcdatamodel-path", "parse a core data model and generate rails models (run from inside the app directory)."
    method_option :prefix, :type => :string, :aliases => "-p", :desc => "Remove the specified prefix from models."
    #method_option :template, :type => :boolean, :aliases => "-t", :desc => "Only display template that would be used"
    def parse(xcdatamodel)
      CoreDataParser.parse(xcdatamodel, options[:prefix])
    end
  end
end