require File.dirname(__FILE__) + "/interlingua/step"
require File.dirname(__FILE__) + "/interlingua/base"
require File.dirname(__FILE__) + "/interlingua/helpers"

# TODO Make this different. For activesupport we need to do the following
require 'rubygems'
require 'active_support'

# Older versions of ruby need oniguruma for better regex support (http://oniguruma.rubyforge.org/)
# require 'oniguruma' if RUBY_VERSION <= "1.8.6" # new version