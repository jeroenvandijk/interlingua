require File.join(File.dirname(__FILE__) + '/helpers/webrat')

module Interlingua
  module Helpers
    
    include Webrat
    
    def these_objects_exist(object_name, table)
      object_name
    end
  
  
    def the_object_exists(object_name, table)
    
    end
  

    def guessed_path_to(page)
      Interlingua::Base.paths.each_pair do |method, regex|
    
        # TODO add test, add keywords, each keyword should be matched with one
        # matched = []
        # %w(object objects).each {|v| 
        #   regex.gsub!("__#{v}__") { |match| matched << [v, match]; "(.+)" }
        # }
        matched = {}
        matched = {}
        new_regex = regex.dup
        %w(object objects).each {|v| 
          new_regex.gsub!("__#{v}__") { |match| matched[v] = match; "(.+)" }
        }
        # regex.gsub!("__objects__") { |match| "(.+)" }
      
        if match = page.scan(/#{new_regex}/) and match.any?
          object = match.flatten.first
        
          resource = find_model_name_from(object) or raise "Add a translation for the object '#{object} in your language file for locale '#{I18n.locale}'"

          if matched['object']
            path_helper = method.gsub('object', resource.to_s)
          elsif matched['objects']
            path_helper = method.gsub('objects', resource.to_s.pluralize)
          else
            raise "nothing matched for #{page}"
          end
          # raise Cucumber::World.methods.sort.inspect + users_path.inspect + new_user_path.inspect + World.respond_to?(:new_user_path).inspect
          # raise "Add a routes for resource #{resource.inspect}" unless Cucumber::World.respond_to?(path_helper)

          return send(path_helper)
        end
      end
    
      path_to(page)
    
    end
  
    def find_model_name_from(translation)
      model_translations = I18n.t('activerecord.models')
      model_name = model_translations.index(translation)
  
      return model_name if model_name
    
      # Go through all pluralization rules to see if we can find it there
      model_translation = model_translations.select {|k,v| v.is_a?(Hash) }.find{ |list| list.second.index(translation) }
    
      return model_translation ? model_translation.first : nil
    end
  
  end
  
end