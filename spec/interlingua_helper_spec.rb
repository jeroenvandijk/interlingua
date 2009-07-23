require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Interlingua::Helpers do
  before(:each) do
    Interlingua::Base.load(:en)
    class Dummy
      include Interlingua::Helpers
      def path_to(*args); end
    end
    @base = Dummy.new
  end
  
  context "#guessed_path_to" do
    
    it "should call the nested index helper" do
      pending do
        @base.should_receive(:user_friends_path)
        @base.guessed_path_to("the index page of friends for an user")
      end
    end
    
    it "should call index helper" do
      @base.should_receive(:users_path)
      @base.guessed_path_to("the index page of users")
    end
    
    it "should call index helper also when symbol is returned" do
      @base.should_receive(:users_path)
      @base.guessed_path_to("the index page of users")
    end
    
    it "should return the index path" do
      @base.stub(:users_path => "/users")
      @base.guessed_path_to("the index page of users").should == "/users"
    end
    
    it "should call path_to when there is no path macro" do
      @base.should_receive(:path_to).with("non-existing page of non-existing object")
      @base.guessed_path_to("non-existing page of non-existing object")
    end
  end
end