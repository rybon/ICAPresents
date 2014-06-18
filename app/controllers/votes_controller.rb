class VotesController < ApplicationController
  before_action :check_logged_in
  before_action :no_admin, only: [:create, :show]
  before_action :check_vote, only: [:create]
  before_action :check_admin, only: [:index, :destroy]

  def index
    @votes = Vote.find_by_sql('SELECT DISTINCT ON(award_id) award_id, project_id, COUNT(id) AS score FROM votes GROUP BY project_id, award_id ORDER BY award_id, score DESC')
    @total = Vote.all.size
    @most_votes = Vote.find_by_sql('SELECT project_id, COUNT(id) AS score FROM votes GROUP BY project_id ORDER BY score DESC').first
    if @total == 0
      redirect_to projects_path, notice: 'No votes have been found yet.'
    end
    ### Other useful queries to list complete rankings of vote totals, or per award category. To be used in Navicat for easy export to .csv:
    #
    # Totals:
    #
    # select distinct dense_rank() over (Results) as Rank, projects.title as Project, count(votes.id) as Votes, round(100.0 * count(votes.id) / (select count(votes.id) from votes), 2) as Percentage
    # from votes
    # join projects on projects.id = votes.project_id
    # group by Project
    # window Results as (order by count(votes.id) desc)
    # order by Rank
    #
    # Best Concept:
    #
    # select distinct dense_rank() over (Results) as Rank, projects.title as Project, awards.name as Award, count(votes.id) as Votes, round(100.0 * count(votes.id) / (select count(votes.id) from votes where votes.award_id = 1), 2) as Percentage
    # from votes
    # join projects on projects.id = votes.project_id
    # join awards on awards.id = votes.award_id
    # where votes.award_id = 1
    # group by votes.award_id, Project, Award
    # window Results as (order by count(votes.id) desc)
    # order by Rank
    #
    # Best Technical Execution:
    #
    # select distinct dense_rank() over (Results) as Rank, projects.title as Project, awards.name as Award, count(votes.id) as Votes, round(100.0 * count(votes.id) / (select count(votes.id) from votes where votes.award_id = 2), 2) as Percentage
    # from votes
    # join projects on projects.id = votes.project_id
    # join awards on awards.id = votes.award_id
    # where votes.award_id = 2
    # group by votes.award_id, Project, Award
    # window Results as (order by count(votes.id) desc)
    # order by Rank
    #
    # Best Presentation:
    #
    # select distinct dense_rank() over (Results) as Rank, projects.title as Project, awards.name as Award, count(votes.id) as Votes, round(100.0 * count(votes.id) / (select count(votes.id) from votes where votes.award_id = 3), 2) as Percentage
    # from votes
    # join projects on projects.id = votes.project_id
    # join awards on awards.id = votes.award_id
    # where votes.award_id = 3
    # group by votes.award_id, Project, Award
    # window Results as (order by count(votes.id) desc)
    # order by Rank
  end

  def show
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.student = current_user
    if @vote.save
      redirect_to projects_path, notice: 'You have voted for ' + @vote.project.title + ' for the award ' + @vote.award.name +  '. Thank you for your vote!'
    else
      redirect_to project_path(vote_params[:project_id]), notice: 'Your vote could not be saved.'
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.destroy
      redirect_to projects_path, notice: 'The vote has been deleted.'
    else
      redirect_to projects_path, notice: 'The vote could not be deleted.'
    end
  end

  private
    def no_admin
      if admin?
        redirect_to projects_path, notice: 'You can\'t vote as an administrator.'
      end
    end

    def check_vote
      if !voting_allowed?.call
        redirect_to projects_path, notice: 'You can only vote during ICA Presents!'
      elsif Award.all.size == current_user.votes.size
        redirect_to projects_path, notice: 'You have already voted, you can\'t vote again!'
      elsif Vote.exists?(student_id: current_user.id, award_id: vote_params[:award_id])
        redirect_to projects_path, notice: 'You have already voted for this award.'
      elsif Project.exists?(id: vote_params[:project_id], approved: false)
        redirect_to projects_path, notice: 'You can\'t vote for a project that is yet to be approved.'
      end
    end

    def check_admin
      unless admin?
        redirect_to projects_path, notice: 'Only administrators have access.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.permit(:award_id, :project_id)
    end
end
