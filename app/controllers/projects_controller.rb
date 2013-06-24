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
        @projects = Project.where(approved: true).order('created_at DESC')
      end
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    unless admin?
      unless @project.approved
        redirect_to projects_path, notice: 'Project is nog niet goedgekeurd.'
      end
    end
    @awards = Award.all
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
        redirect_to projects_path, notice: 'Project is toegevoegd.'
      else
        redirect_to projects_path, notice: 'Project is toegevoegd, maar nog niet goedgekeurd.'
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project is bijgewerkt.'
    else
      render action: 'edit'
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Project is verwijderd.'
    else
      redirect_to projects_path, notice: 'Project kon niet verwijderd worden.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def check_project
      unless admin?
        # if voting_allowed?.call and (params[:action] == 'new' or params[:action] == 'create')
          # redirect_to projects_path, notice: 'ICA Presents is begonnen. Je kan geen project meer toevoegen.'
        if (params[:action] == 'new' or params[:action] == 'create') and current_user.project.try(:id)
          redirect_to projects_path, notice: 'Je hebt al een project toegevoegd.'
        elsif (params[:action] == 'edit' or params[:action] == 'update' or params[:action] == 'destroy') and current_user.project.try(:id) and current_user.project.try(:id) != @project.id
          redirect_to projects_path, notice: 'Je mag alleen je eigen project bijwerken of verwijderen.'
        end
      else
        raise
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
