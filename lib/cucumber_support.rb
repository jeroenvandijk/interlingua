require File.dirname(__FILE__) + "/cucumber_support/step"
require File.dirname(__FILE__) + "/cucumber_support/base"
require File.dirname(__FILE__) + "/cucumber_support/helpers"

# TODO Make this different. For activesupport we need to do the following
require 'rubygems'
require 'active_support'

# Older versions of ruby need oniguruma for better regex support (http://oniguruma.rubyforge.org/)
# require 'oniguruma' if RUBY_VERSION <= "1.8.6" # new version