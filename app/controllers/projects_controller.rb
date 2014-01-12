class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_in, except: [:index, :show]
  before_action :check_project, except: [:index, :show]

  # GET /projects
  # GET /projects.json
  def index
    if admin?
      if params[:search].present?
        @search = params[:search]
        @projects = Project.where('title ILIKE ? OR students ILIKE ? OR semester ILIKE ? OR description ILIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%" , "%#{params[:search]}%").order('created_at DESC')
      else
        @projects = Project.all.order('created_at DESC')
      end
    else
      if params[:search].present?
        @search = params[:search]
        @projects = Project.where(approved: true).where('title ILIKE ? OR students ILIKE ? OR semester ILIKE ? OR description ILIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%" , "%#{params[:search]}%").order('created_at DESC')
      else
        @projects = Project.where(approved: true).order('title')
      end
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    unless admin?
      unless @project.approved
        redirect_to projects_path, notice: 'Project is not approved yet.'
      end
    end
    @awards = Award.all.order(:id)
  end

  # GET /projects/new
  def new
    unless current_user.try(:admin?) 
      @project = Project.new(students: current_user.name)
    else
      @project = Project.new
    end
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.author = current_user
    if @project.save
      NewProjectMailer.new_project_email(@project).deliver
      if @project.approved
        redirect_to projects_path, notice: 'Project has been added.'
      else
        redirect_to projects_path, notice: 'Project has been added, but will have to be approved by an administrator.'
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Changes saved.'
    else
      render action: 'edit'
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Project has been deleted.'
    else
      redirect_to projects_path, notice: 'Project could not be deleted.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.where(id: params[:id]).first
      unless @project
        redirect_to projects_path, notice: 'Project not found.'
      end
    end

    def check_project
      unless admin?
        if voting_allowed?.call and (params[:action] == 'new' or params[:action] == 'create')
          redirect_to projects_path, notice: 'ICA Presents has started. You can no longer add a project.'
        elsif (params[:action] == 'new' or params[:action] == 'create') and current_user.project.try(:id)
          redirect_to projects_path, notice: 'You have already added a project.'
        elsif (params[:action] == 'edit' or params[:action] == 'update' or params[:action] == 'destroy') and (!current_user.project.try(:id) || current_user.project.try(:id) and current_user.project.try(:id) != @project.id)
          redirect_to projects_path, notice: 'You can only edit or delete your own project.'
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      if admin?
        params[:project].permit(:title, :students, :semester, :location, :time, :description, :picture, :approved)
      elsif current_user
        params[:project].permit(:title, :students, :semester, :location, :time, :description, :picture)
      end
    end
end
