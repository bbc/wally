require 'spec_helper'

describe 'Application' do
  include Rack::Test::Methods

  let(:app) { Sinatra::Application }

  describe '/projects/:project/pushes' do
    let(:projects_service) { double('project service').as_null_object }
    
    let(:project) { double('project').as_null_object }

    before do
      Wally::Project.stub(:find_by_name).and_return(project)
      Sinatra::Application.any_instance.stub(:projects_service => projects_service)
    end
    
    it 'responds with 404:not_found when project is not found' do
      Wally::Project.stub(:find_by_name).and_return(nil)
      post '/projects/foo/pushes'
      last_response.status.should == 404
    end
    
    describe 'a successful import' do
      it 'pushes features to project' do
        projects_service.should_receive(:tar_gz_push) do |p, io|
          p.should be_equal(project)
          io.read.should == 'posted content'
        end   
        post '/projects/foo/pushes', 'posted content'
      end
      
      it 'saves the project' do
        project.should_receive(:save)
        post '/projects/foo/pushes', 'posted content'
      end
      
      it 'returns a 201 response' do
        post '/projects/foo/pushes'
        last_response.status.should == 201
      end
    end
  end
end
      
    