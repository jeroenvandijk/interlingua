require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe CucumberSupport::Step do
    
  describe "simple case" do
    before(:each) do
      translation_method = "foo"
      translation = "foo"
      @step = CucumberSupport::Step.new(translation_method, translation)
      # raise @step.inspect
    end


    it "should return the correct regular expression" do
      @step.regex.should == /^foo$/
    end

    it "should return the correct string representation" do
      @step.name.should == "foo"
    end

    it "should return the correct proc" do
      @step.should_receive(:foo)
      @step.block.call
    end

    it "should return the correct arity" do
      @step.arity.should == 0
    end
  end


  describe "complex case" do
    before(:each) do
      translation_method = "bar"
      translation = "bar __page_name__"
      @step = CucumberSupport::Step.new(translation_method, translation)
    end

    it "should return the correct regular expression" do
      @step.regex.should == /^bar (.+)$/ 
    end

    it "should return the correct string representation" do
      @step.name.should == "bar page_name"
    end

    it "should return the correct proc" do
      @step.should_receive(:bar).with("foo")
      @step.block.call("foo")
    end

    it "should return the correct arity" do
      @step.arity.should == 1
    end
  end
  
  describe "multiple arguments" do
    before(:each) do
      translation_method = "bar"
      translation = %{bar __object__ "__page_name__"}
      @step = CucumberSupport::Step.new(translation_method, translation)
    end
    
    it "should return the correct regular expression" do
      @step.regex.should == /^bar (.+) "([^\"]*)"$/ 
    end

    it "should return the correct string representation" do
      @step.name.should == %{bar object "page_name"}
    end

    it "should return the correct proc" do
      @step.should_receive(:bar).with("foo", "bar")
      @step.block.call("foo", "bar")
    end

    it "should return the correct arity" do
      @step.arity.should == 2
    end
  end
  
  describe "multiple arguments (2)" do
    before(:each) do
      translation_method = "bar"
      translation = %{bar "__page_name__" __object__}
      @step = CucumberSupport::Step.new(translation_method, translation)
    end
    
    it "should return the correct regular expression" do
      @step.regex.should == /^bar "([^\"]*)" (.+)$/ 
    end

    it "should return the correct string representation" do
      @step.name.should == %{bar "page_name" object}
    end

    it "should return the correct proc" do
      @step.should_receive(:bar).with("foo", "bar")
      @step.block.call("foo", "bar")
    end

    it "should return the correct arity" do
      @step.arity.should == 2
    end
  end
  
  describe "arity as option" do
    before(:each) do
      translation_method = "bar"
      translation = %{bar "__page_name__" __object__}
      @step = CucumberSupport::Step.new(translation_method, translation, :arity => 27)
    end

    it "should return the correct arity" do
      @step.arity.should == 27
    end
  end
  
end