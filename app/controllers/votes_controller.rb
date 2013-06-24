class VotesController < ApplicationController
  before_action :check_logged_in
  before_action :no_admin, only: [:create, :show]
  before_action :check_vote, only: [:create]
  before_action :check_admin, only: [:index, :destroy]

  def index
    @votes = Vote.find_by_sql('SELECT award_id, project_id, COUNT(*) AS score FROM votes GROUP BY project_id, award_id ORDER BY award_id, score DESC')
    @total = Vote.all.size
    @most_votes = Vote.find_by_sql('SELECT project_id, COUNT(*) AS score FROM votes GROUP BY project_id ORDER BY score DESC').first
    if @total == 0
      redirect_to projects_path, notice: 'Er zijn nog geen stemmen uitgebracht.'
    end
  end

  def show
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.student = current_user
    if @vote.save
      redirect_to projects_path, notice: 'Je hebt je stem in de categorie ' + @vote.award.name + ' uitgebracht op het project ' + @vote.project.title +  '. Bedankt!'
    else
      redirect_to project_path(vote_params[:project_id]), notice: 'Je stem kon niet uitgebracht worden.'
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.destroy
      redirect_to projects_path, notice: 'De stem is verwijderd.'
    else
      redirect_to projects_path, notice: 'De stem kon niet verwijderd worden.'
    end
  end

  private
    def no_admin
      if admin?
        redirect_to projects_path, notice: 'Als beheerder mag je niet stemmen.'
      end
    end

    def check_vote
      if !voting_allowed?
        redirect_to projects_path, notice: 'Je mag op dit tijdstip nog niet stemmen. Wacht totdat ICA Presents is begonnen.'   
      elsif Award.all.size == current_user.votes.size
        redirect_to projects_path, notice: 'Je hebt al je stemmen uitgebracht. Je kan niet nogmaals stemmen.'
      elsif Vote.exists?(student_id: current_user.id, award_id: vote_params[:award_id])
        redirect_to projects_path, notice: 'Je hebt je stem al in deze categorie uitgebracht.'
      elsif Project.exists?(id: vote_params[:project_id], approved: false)
        redirect_to projects_path, notice: 'Je kan niet stemmen op een niet goedgekeurd project.'
      end
    end

    def check_admin
      unless admin?
        redirect_to projects_path, notice: 'Alleen beheerders hebben toegang.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.permit(:award_id, :project_id)
    end
end
