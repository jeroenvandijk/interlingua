require File.join(File.dirname(__FILE__), '/base')
require File.join(File.dirname(__FILE__), '/helpers')

CucumberSupport::Base.load(:nl)

World(CucumberSupport::Helpers)
# raise CucumberSupport::Base.translations['given'].inspect

CucumberSupport::Base.steps.each do |step|
  instance_eval do
    Given(step.regex, &step.block)
  end
  
end
# 
# CucumberSupport::Base.translations['when'].each do |translation_method, translation|
#   instance_eval do
#     When(/#{translation}/) { |*args| send(translation_method, *args) }
#   end
# end
# 
# CucumberSupport::Base.translations['then'].each do |translation_method, translation|
#   instance_eval do
#     Then(/#{translation}/) { |*args| send(translation_method, *args) }
#   end
# end
#   

# end
# World(CucumberSupport)