module CucumberSupport
  class Step
    
    # Because we cannot use lookbehind (1.8.6>), the order of these regular expressions is important
    MAPPINGS = [
      { :string =>  /"__(\w+)__"/i, :regex =>  '"([^\"]*)"' },
      { :string =>  /__(\w+)__/i, :regex =>  '(.+)' } # unfortuna
      # { :string =>  /[^"]?__(\w+)__[^"]?/i, :regex =>  '(.+)' }
    ] # do something here
    
    attr_reader :translation_method, :translation
        
    def initialize(translation_method, translation, options = {})
      @translation_method, @translation = translation_method, translation
      @arity = options[:arity]
    end
    
    def regex
      return @regex if @regex
      regex = MAPPINGS.inject(translation) { |result, mapping| result.gsub(mapping[:string], mapping[:regex]) }
      @regex = /^#{regex}$/
    end
    
    def name
      @name ||= MAPPINGS.inject(translation){ |result, mapping| result.sub(mapping[:string]) { |match| match.gsub('__', '') } } 
    end
    
    # FIXME the code below is unnecessary complex due to 1.8.6 lack of Regex lookbehinds
    def arity
      # Unfortunately, we cannot use lookbehind and ahead (Ruby 1.9.1), thus we need to add some code to compensate this, otherwise we could do this in a one liner
      return @arity if @arity
      
      tmp_translation = translation.dup
      @arity ||= MAPPINGS.inject(0) do |result, mapping| 
        occurences_found = tmp_translation.scan(mapping[:string]).size;
        tmp_translation.gsub!(mapping[:string], '------')
        result + occurences_found  
      end
    end

    def block
      eval(<<-BLOCK
            proc { #{ '|' + block_arguments + '|' if arity > 0}
              #{translation_method} #{block_arguments}
            }
           BLOCK
           )
    end 
    
    private

    def block_arguments
      (1..arity).map { |x| "arg#{x}" }.join(',')
    end
    
    
  end

  
end