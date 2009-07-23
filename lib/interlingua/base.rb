require File.dirname(__FILE__) + "/step"
# TODO test if world exists
# module Interlingua
module Interlingua
  class Base

    class << self
      attr_reader :steps, :paths
    end
    
    def self.load(locale)
      definition = YAML::load_file(File.join(File.dirname(__FILE__), "/languages/#{locale}.yml" ) )
      
      @steps = []
      %W(given when then).each do |prefix| 
        definition['steps'][prefix].each do |old_translation_method, translation| 
          translation_method, arity = old_translation_method.split(";")
        
          new_step_proc = proc{ |t| @steps << Step.new(translation_method, t, :arity => arity && arity.to_i) }
          
          translation.respond_to?(:each) ? translation.each(&new_step_proc) : new_step_proc.call(translation)
        end
      end

      @paths = parse_paths(definition['paths'])
    end
    
    private
      
    def self.parse_paths(definition)
      definition
    end
        
  end
end
