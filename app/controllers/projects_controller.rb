class ProjectsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found'
  end

  def index
    @projects = Project.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @project = Project.find(params[:id])
    @project.tasks.build
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

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = params[:adding_task] ? 'Task successufully added to project' : 'Project successfully updated'
      redirect_to @project
    else
      unless params[:adding_task]
        flash[:notice] = 'Unable to update project'
        render :edit
      else
        flash[:notice] = 'Unable to add task to project'
        render :show
      end
    end
  end
end
