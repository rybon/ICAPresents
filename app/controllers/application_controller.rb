class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def current_user
      if session[:student_id]
        @current_user ||= Student.where(id: session[:student_id]).first
      elsif session[:teacher_id]
        @current_user ||= Teacher.where(id: session[:teacher_id]).first
      end
    end

    def check_logged_in
      redirect_to root_url, notice: "Log eerst in." unless current_user
    end

    def check_logged_out
      redirect_to root_url, notice: "Je bent al ingelogd." if current_user
    end

    def admin?
      current_user and current_user.try(:admin?)
    end

    def voting_allowed?
      ((Time.zone.now.utc.to_i * 1000) > (Home.first.ica_presents_begins.utc.to_i * 1000) and (Time.zone.now.utc.to_i * 1000) < ica_presents_ends)
    end

    def ica_presents_ends
      (Home.first.ica_presents_begins.utc.to_i * 1000) + 2.hours.to_i
    end

    helper_method :current_user, :check_logged_in, :check_logged_out, :admin?, :voting_allowed?, :ica_presents_ends
end
