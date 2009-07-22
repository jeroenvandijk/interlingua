
# Add specs for three cases
# - no I18n 
# - simple
# - complex translation
# - caching
# def find_model_name_from(translation)
#   model_translations = I18n.t('activerecord.models')
#   model_name = model_translations.index(translation)
# 
#   return model_name if model_name
#   
#   # Go through all pluralization rules to see if we can find it there
#   model_translation = model_translations.select {|k,v| v.is_a?(Hash) }.find{ |list| list.second.index(translation) }
#   
#   return model_translation ? model_translation.first : nil
# end

# Add specs for two cases no I18n, simple and complex translation
# find_attribute_name_for(model, attribute_translation)
#

# Add specs to see if it does the right thing 
# def plural_name?(model_name)
#   translation = find_model_translation(model_name)
#   
#   return false unless translation.is_a?(Hash)
#   
#   return translation.index(model_name) != :one
# end