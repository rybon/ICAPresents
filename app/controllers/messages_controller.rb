class MessagesController < ApplicationController
  respond_to :html, :json
  before_action :check_admin, except: [:index]

  def index
    if params[:latest]
      @messages = Message.where('id > ?', params[:latest]).order('id DESC')
    else
      @messages = Message.all.order('id DESC')
    end
    respond_with @messages
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.teacher = current_user
    if @message.save
      redirect_to messages_path, notice: 'Het bericht is toegevoegd.'
    else
      render action: 'new'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      redirect_to messages_path, notice: 'Het bericht is verwijderd.'
    else
      redirect_to messages_path, notice: 'Het bericht kon niet verwijderd worden.'
    end
  end

  private
    def check_admin
      unless admin?
        redirect_to root_url, notice: 'Alleen beheerders hebben toegang.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params[:message].permit(:content)
    end
end
