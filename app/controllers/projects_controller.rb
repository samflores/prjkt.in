class ProjectsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found'
  end

  def index
    @projects = Project.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @project = Project.find(params[:id])
  end
end
