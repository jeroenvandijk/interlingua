require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe CucumberSupport::Helpers do
  before(:each) do
    class Dummy
      include CucumberSupport::Helpers
      def path_to(*args); end
    end
    @base = Dummy.new
    module I18n; end
  end
  
  context "#guessed_path_to" do
    it "should call index helper" do
      I18n.stub(:t => { "user" => "users" })
      CucumberSupport::Base.stub(:paths => { "objects_path" => "index page of __objects__"})

      @base.should_receive(:users_path)
      @base.guessed_path_to("index page of users")
      
    end
    
    it "should call index helper also when symbol is returned" do
      I18n.stub(:t => { :user => "users" })
      CucumberSupport::Base.stub(:paths => { "objects_path" => "index page of __objects__"})

      @base.should_receive(:users_path)
      @base.guessed_path_to("index page of users")
      
    end
    
    it "should return the index path" do
      I18n.stub(:t => { :user => "users" })
      CucumberSupport::Base.stub(:paths => { "objects_path" => "index page of __objects__"})

      @base.stub(:users_path => "/users")
      @base.guessed_path_to("index page of users").should == "/users"
    end
  end
end