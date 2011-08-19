class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

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
    @project = Project.new(params[:project].merge(:owner => current_user))
    if @project.save
      flash[:notice] = 'Project successfully saved'
      redirect_to @project
    else
      flash.now[:alert] = 'Unable to save project'
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if not params[:adding_task]
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project successfully updated'
        redirect_to @project
      else
        flash.now[:alert] = 'Unable to update project'
        render :edit
      end
    else
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project tasks successfully updated'
        redirect_to @project
      else
        flash.now[:alert] = 'Unable to update project tasks'
        render :show
      end
    end
  end
end
