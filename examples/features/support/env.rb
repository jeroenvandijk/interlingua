require File.join(File.dirname(__FILE__), "/../../../lib/interlingua/cucumber")

module SimpleWorld
  def method_missing(*args)
    method, *arguments = *args
    puts "#{method}(#{arguments.inspect})"
  end

end

World(SimpleWorld)