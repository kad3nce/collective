# require merb-gen and the spec helpers
require 'merb-gen'
require 'merb-gen/spec_helper'

# require our other spec helpers
require File.join(File.dirname(__FILE__), '..', 'spec_helper')

# require the generators
require 'generators/data_mapper_migration'
require 'generators/data_mapper_model'
require 'generators/data_mapper_resource_controller'

# include the helpers
Spec::Runner.configure do |config|
  config.include Merb::Test::GeneratorHelper
end

# copied from merb-more/merb-gen/spec/spec_helpers.rb
# 07/08/2008

shared_examples_for "named generator" do

  describe '#file_name' do

    it "should convert the name to snake case" do
      @generator.name = 'SomeMoreStuff'
      @generator.file_name.should == 'some_more_stuff'
    end

    it "should preserve dashes" do
      @generator.name = "project-pictures"
      @generator.file_name.should == "project-pictures"
    end

  end

  describe '#base_name' do

    it "should convert the name to snake case" do
      @generator.name = 'SomeMoreStuff'
      @generator.base_name.should == 'some_more_stuff'
    end

    it "should preserve dashes" do
      @generator.name = "project-pictures"
      @generator.base_name.should == "project-pictures"
    end

  end

  describe "#symbol_name" do

    it "should snakify the name" do
      @generator.name = "ProjectPictures"
      @generator.symbol_name.should == "project_pictures"
    end

    it "should replace dashes with underscores" do
      @generator.name = "project-pictures"
      @generator.symbol_name.should == "project_pictures"
    end

  end

  describe '#class_name' do

    it "should convert the name to camel case" do
      @generator.name = 'some_more_stuff'
      @generator.class_name.should == 'SomeMoreStuff'
    end

    it "should convert a name with dashes to camel case" do
      @generator.name = 'some-more-stuff'
      @generator.class_name.should == 'SomeMoreStuff'
    end

  end

  describe '#module_name' do

    it "should convert the name to camel case" do
      @generator.name = 'some_more_stuff'
      @generator.module_name.should == 'SomeMoreStuff'
    end

    it "should convert a name with dashes to camel case" do
      @generator.name = 'some-more-stuff'
      @generator.module_name.should == 'SomeMoreStuff'
    end

  end

  describe '#test_class_name' do

    it "should convert the name to camel case and append 'test'" do
      @generator.name = 'some_more_stuff'
      @generator.test_class_name.should == 'SomeMoreStuffTest'
    end

  end

end

shared_examples_for "namespaced generator" do

  describe "#class_name" do
    it "should camelize the name" do
      @generator.name = "project_pictures"
      @generator.class_name.should == "ProjectPictures"
    end

    it "should split off the last double colon separated chunk" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.class_name.should == "ProjectPictures"
    end

    it "should split off the last slash separated chunk" do
      @generator.name = "test/monkey/project_pictures"
      @generator.class_name.should == "ProjectPictures"
    end

    it "should convert a name with dashes to camel case" do
      @generator.name = 'some-more-stuff'
      @generator.class_name.should == 'SomeMoreStuff'
    end
  end

  describe "#module_name" do
    it "should camelize the name" do
      @generator.name = "project_pictures"
      @generator.module_name.should == "ProjectPictures"
    end

    it "should split off the last double colon separated chunk" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.module_name.should == "ProjectPictures"
    end

    it "should split off the last slash separated chunk" do
      @generator.name = "test/monkey/project_pictures"
      @generator.module_name.should == "ProjectPictures"
    end

    it "should convert a name with dashes to camel case" do
      @generator.name = 'some-more-stuff'
      @generator.module_name.should == 'SomeMoreStuff'
    end
  end

  describe "#modules" do
    it "should be empty if no modules are passed to the name" do
      @generator.name = "project_pictures"
      @generator.modules.should == []
    end

    it "should split off all but the last double colon separated chunks" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.modules.should == ["Test", "Monkey"]
    end

    it "should split off all but the last slash separated chunk" do
      @generator.name = "test/monkey/project_pictures"
      @generator.modules.should == ["Test", "Monkey"]
    end
  end

  describe "#file_name" do
    it "should snakify the name" do
      @generator.name = "ProjectPictures"
      @generator.file_name.should == "project_pictures"
    end

    it "should preserve dashes" do
      @generator.name = "project-pictures"
      @generator.file_name.should == "project-pictures"
    end

    it "should split off the last double colon separated chunk and snakify it" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.file_name.should == "project_pictures"
    end

    it "should split off the last slash separated chunk and snakify it" do
      @generator.name = "test/monkey/project_pictures"
      @generator.file_name.should == "project_pictures"
    end
  end

  describe "#base_name" do
    it "should snakify the name" do
      @generator.name = "ProjectPictures"
      @generator.base_name.should == "project_pictures"
    end

    it "should preserve dashes" do
      @generator.name = "project-pictures"
      @generator.base_name.should == "project-pictures"
    end

    it "should split off the last double colon separated chunk and snakify it" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.base_name.should == "project_pictures"
    end

    it "should split off the last slash separated chunk and snakify it" do
      @generator.name = "test/monkey/project_pictures"
      @generator.base_name.should == "project_pictures"
    end
  end

  describe "#symbol_name" do
    it "should snakify the name and replace dashes with underscores" do
      @generator.name = "project-pictures"
      @generator.symbol_name.should == "project_pictures"
    end

    it "should split off the last slash separated chunk, snakify it and replace dashes with underscores" do
      @generator.name = "test/monkey/project-pictures"
      @generator.symbol_name.should == "project_pictures"
    end
  end

  describe "#test_class_name" do
    it "should camelize the name and append 'Test'" do
      @generator.name = "project_pictures"
      @generator.test_class_name.should == "ProjectPicturesTest"
    end

    it "should split off the last double colon separated chunk" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.test_class_name.should == "ProjectPicturesTest"
    end

    it "should split off the last slash separated chunk" do
      @generator.name = "test/monkey/project_pictures"
      @generator.test_class_name.should == "ProjectPicturesTest"
    end
  end

  describe "#full_class_name" do
    it "should camelize the name" do
      @generator.name = "project_pictures"
      @generator.full_class_name.should == "ProjectPictures"
    end

    it "should camelize a name with dashes" do
      @generator.name = "project-pictures"
      @generator.full_class_name.should == "ProjectPictures"
    end

    it "should leave double colon separated chunks" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.full_class_name.should == "Test::Monkey::ProjectPictures"
    end

    it "should convert slashes to double colons and camel case" do
      @generator.name = "test/monkey/project_pictures"
      @generator.full_class_name.should == "Test::Monkey::ProjectPictures"
    end
  end

  describe "#base_path" do
    it "should be blank for no namespaces" do
      @generator.name = "project_pictures"
      @generator.base_path.should == ""
    end

    it "should snakify and join namespace for double colon separated chunk" do
      @generator.name = "Test::Monkey::ProjectPictures"
      @generator.base_path.should == "test/monkey"
    end

    it "should leave slashes but only use the namespace part" do
      @generator.name = "test/monkey/project_pictures"
      @generator.base_path.should == "test/monkey"
    end
  end

end
