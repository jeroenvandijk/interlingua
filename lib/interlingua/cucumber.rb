require File.join(File.dirname(__FILE__), '/base')
require File.join(File.dirname(__FILE__), '/helpers')

Interlingua::Base.load(:nl)  # TODO Needs to be loaded dynamically somehow

World(Interlingua::Helpers)

Interlingua::Base.steps.each do |step|
  instance_eval do
    Given(step.regex, &step.block)
  end
  
end
# 
# Interlingua::Base.translations['when'].each do |translation_method, translation|
#   instance_eval do
#     When(/#{translation}/) { |*args| send(translation_method, *args) }
#   end
# end
# 
# Interlingua::Base.translations['then'].each do |translation_method, translation|
#   instance_eval do
#     Then(/#{translation}/) { |*args| send(translation_method, *args) }
#   end
# end
#   

# end
# World(Interlingua)