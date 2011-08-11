class ProjectsController < ApplicationController
  def index
    @projects = Project.paginate(:page => params[:page], :per_page => 10)
  end
end
