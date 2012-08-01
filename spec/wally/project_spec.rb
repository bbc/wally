require File.join(File.dirname(__FILE__), "..", "spec_helper")
require 'fileutils'

module Wally
  describe Project do
    it "stores a name" do
      Project.create(:name => "project1")
      Project.first.name.should == "project1"
    end

    it "stores features" do
      Project.create({:name => "project2", :features => [
          Feature.new(:path => "feature/path")
      ]})
      Project.first.features.first.path.should == "feature/path"
    end
    
    describe '#import_content(path, io)', 'imports generated project artifacts' do
      describe 'a first level .feature' do
        before do
          Feature.stub(:parse_feature).and_return(Feature.new)
        end
        
        it 'adds the feature to the project' do
          feature_io = StringIO.new('Feature: A feature')
          Feature.should_receive(:parse_feature).with('a.feature', feature_io).and_return(Feature.new)
          subject.import_content('a.feature', feature_io)
        end
        
        it 'adds a topic for the feature' do
          subject.import_content('a.feature', StringIO.new)
          subject.topic('a').should_not be_nil
        end
        
        it 'links the feature with and the topic' do
          feature = double('Feature', :id => 'featureid').as_null_object
          Feature.stub(:parse_feature).and_return(feature)
          subject.import_content('a.feature', StringIO.new)
          subject.topic('a').feature_id.should == 'featureid'
        end
      end
      
      describe 'a nested .feature' do
        it 'adds a topic for each parent element in the feature path' do
          subject.import_content('foo/bar/baz/a.feature', StringIO.new)
          subject.topic('foo').should_not be_nil
          subject.topic('foo/bar').should_not be_nil
          subject.topic('foo/bar/baz').should_not be_nil
          subject.topic('foo/bar/baz/a').should_not be_nil
        end
      end
    end

    describe '#topic(path)', 'looks up a topic by path' do
      it 'finds top level topic' do
        subject.topics << Topic.new(:path => 'foo')
        subject.topic('foo').path.should == 'foo'
      end
      
      it 'finds nested topics' do
        subject.topics << foo = Topic.new(:path => 'foo')
        foo.children << foo_bar = Topic.new(:path => 'foo/bar')
        foo_bar.children << Topic.new(:path => 'foo/bar/baz')
        subject.topic('foo/bar/baz').path.should == 'foo/bar/baz'
      end
      
      it 'returns nil when no topic for path is found' do
        subject.topic('foo').should be_nil
      end
      
      it 'finds topics using :\'s or /\'s for separators' do
        subject.topics << foo = Topic.new(:path => 'foo')
        foo.children << foo_bar = Topic.new(:path => 'foo/bar')
        foo_bar.children << Topic.new(:path => 'foo/bar/baz')
        subject.topic('foo:bar:baz').path.should == 'foo/bar/baz'
      end
    end
  end
end
