require 'spec_helper'

module Wally
  describe ProjectCustomizer do
    let(:project) { Wally::Project.new }
    
    def customize(config)
      ProjectCustomizer.customize(project, config)
    end
    
    describe 'topic renaming' do
      example '"foo (Something else for foo)" renames "foo" to "Something else for foo"' do
        project.add_topic(foo = Topic.new(:path => 'foo'))
        customize(['foo (Something else for foo)'])
        foo.name.should == 'Something else for foo'
      end

      it 'works on top-level topics with sub-topics' do
        project.add_topic(foo = Topic.new(:path => 'foo'))
        foo.add_child(foo_a = Topic.new(:path => 'foo/a'))
        customize([{'foo (Something else):' => ['a']}])
        foo.name.should == 'Something else'
      end

      it 'works on sub-topics' do
        project.add_topic(foo = Topic.new(:path => 'foo'))
        foo.add_child(foo_a = Topic.new(:path => 'foo/a'))
        customize([{'foo (Something for foo):' => ['a (Something for a)']}])
        foo.name.should == 'Something for foo'
        foo_a.name.should == 'Something for a'
      end
    end

    describe 'topic sort weights are set from position in config' do
      it 'works with flat structure' do
        project.add_topic(foo = Topic.new(:path => 'foo'))
        project.add_topic(bar = Topic.new(:path => 'bar'))
        project.add_topic(baz = Topic.new(:path => 'baz'))
        customize(['baz', 'foo', 'bar'])
        baz.sort_weight.should == 0
        foo.sort_weight.should == 1
        bar.sort_weight.should == 2
      end

      it 'works with a mix of top level and nested' do
        project.add_topic(foo = Topic.new(:path => 'foo'))
        project.add_topic(bar = Topic.new(:path => 'bar'))
        foo.add_child(foo_a = Topic.new(:path => 'foo/a'))
        foo.add_child(foo_b = Topic.new(:path => 'foo/b'))
        customize([{'foo' => ['b', 'a']}, 'bar'])
        foo.sort_weight.should == 0
        bar.sort_weight.should == 1
        foo_b.sort_weight.should == 0
        foo_a.sort_weight.should == 1
      end

      it 'works with or without .feature extension' do
        project.add_topic(foo = Topic.new(:path => 'foo'))
        project.add_topic(bar = Topic.new(:path => 'bar'))
        project.add_topic(baz = Topic.new(:path => 'baz'))
        customize(['baz.feature', 'foo', 'bar.feature'])
        baz.sort_weight.should == 0
        foo.sort_weight.should == 1
        bar.sort_weight.should == 2
      end
      
      it 'picks up sort weight for renamed topics' do
        project.add_topic(foo = Topic.new(:path => 'foo'))
        project.add_topic(bar = Topic.new(:path => 'bar'))
        foo.add_child(foo_a = Topic.new(:path => 'foo/a'))
        foo.add_child(foo_b = Topic.new(:path => 'foo/b'))
        customize([{'foo  (Better label for foo)' => ['b (Better label for b)', 'a']}, 'bar'])
        foo.sort_weight.should == 0
        bar.sort_weight.should == 1
      end
    end
    
    it 'ignores config entries with no corresponding topic' do
      customize(['foo'])
    end
  end
end
