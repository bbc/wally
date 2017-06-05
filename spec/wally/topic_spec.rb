require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Wally
  describe Topic do
    describe '#topic(path)', 'looks up a descendant topic' do
      it 'returns self when path matches' do
        subject.path = 'topic/path'
        subject.topic('topic/path').should == subject
      end
      
      it 'returns nil without consulting children when path is not a match' do
        subject.children << c1 = Topic.new
        subject.path = 'foo/path'
        c1.should_not_receive(:topic)
        subject.topic('bar/path').should be_nil
      end
      
      it 'finds descendent topic' do
        subject.path = 'foo'
        subject.children << foo_bar = Topic.new(:path => 'foo/bar')
        foo_bar.children << Topic.new(:path => 'foo/bar/topic')
        subject.topic('foo/bar/topic').path.should == 'foo/bar/topic'
      end
    end
    
    describe '#ensure_descendents(path)', 'acts like mkdir -p for topics' do
      it 'returns self when path matches' do
        subject.path = 'foo'
        subject.ensure_descendents('foo').should == subject
      end
      
      specify 'extension in path is ignored' do
        subject.path = 'foo'
        subject.ensure_descendents('foo.feature').should == subject
      end
      
      context 'with a direct child path' do
        it 'returns a newly instantiated child topic' do
          subject.path = 'foo'
          subject.ensure_descendents('foo/bar').path.should == 'foo/bar'
          subject.children.map(&:path).should include('foo/bar')
        end
      end

      context 'with non immediate descendent path' do
        it 'creates new topics' do
          subject.path = 'foo'
          subject.ensure_descendents('foo/bar/baz').path.should == 'foo/bar/baz'
          subject.child('foo/bar').child('foo/bar/baz').should_not be_nil
        end
        
        specify 'already existing descendent topics are added to' do
          subject.path = 'foo'
          subject.children << foo_bar = Topic.new(:path => 'foo/bar')
          foo_bar.children << Topic.new(:path => 'foo/bar/a')
          subject.ensure_descendents('foo/bar/b')
          foo_bar.children.map(&:path).should include('foo/bar/a', 'foo/bar/b')
        end
      end
    end
    
    describe '#<=>(other)', 'comparison operator' do
      it 'a topic with a lighter sort weight is before one with a heavier sort weight' do
        subject.sort_weight = 5
        other = Topic.new(:sort_weight => 3)
        (subject <=> other).should == 1
        (other <=> subject).should == -1
      end
      
      specify 'a topic with a sort weight is before a topic with no sort weight' do
        subject.sort_weight = 1000
        other = Topic.new(:sort_weight => nil)
        (subject <=> other).should == -1
        (other <=> subject).should == 1
      end
      
      specify 'two topics without an explicit sort weight are ordered by name' do
        subject.sort_weight = nil
        subject.name = 'foo'
        other = Topic.new(:sort_weight => nil, :name => 'bar')
        (subject <=> other).should == 1
        (other <=> subject).should == -1
      end
    end
  end
end
