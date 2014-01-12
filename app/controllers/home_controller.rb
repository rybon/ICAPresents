class HomeController < ApplicationController
  before_action :admin?, except: [:index]

  def index
    @messages = Message.all.order('id DESC')
    @home = Home.first
  end

  def edit
    @home = Home.first
  end

  def update
    @home = Home.first
    if @home.update(home_params)
      redirect_to root_url, notice: 'Changes saved.'
    else
      render action: 'edit'
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params[:home].permit(:ica_presents_begins, :program, :about)
    end
end
