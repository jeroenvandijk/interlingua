require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'interlingua'



Spec::Runner.configure do |config|
  
end

I18n.load_path << File.join(File.dirname(__FILE__), "locales/en.yml")