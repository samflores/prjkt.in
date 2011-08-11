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

  def new 
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = 'Project successfully saved'
      redirect_to @project
    else
      flash[:notice] = 'Unable to save project'
      render :new
    end
  end
end
