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
        matched = []
        new_regex = regex.gsub(/__([^\s]+)__/) { |match| matched << $1; '(\w+(?:(?:\s+\w+))*)' }

        if match = page.scan(/^#{new_regex}$/) and match.any?
          path_helper = method.dup
          match.flatten.each_with_index do |translation, i|
            rule_name, resource_name = find_model_rule_from(translation) || raise("Add a translation for the object '#{translation}' in your language file for locale '#{I18n.locale}'")
            resource = rule_name == :one ? resource_name : resource_name.pluralize
            path_helper.gsub!("#{matched[i]}", resource)
          end

          return send(path_helper)
        end
      end

      path_to(page)
    end
    
    def find_model_name_from(translation)
      find_model_rule_from(translation)[1]
    end

    private
    
    def find_model_rule_from(translation)
      model_translations = I18n.t('activerecord.models')
      model_name = model_translations.index(translation)
  
      return model_name if model_name
    
      # Go through all pluralization rules to see if we can find it there
      model_translation_rules = model_translations.select {|k,v| v.is_a?(Hash) }

      rule, resource_name = []
      model_translation_rules.find { |list| resource_name = list.first.to_s if rule = list.second.index(translation) }

      [rule, resource_name]
    end
  
  end
  
end