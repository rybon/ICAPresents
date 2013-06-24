class SessionsController < ApplicationController
  before_action :check_logged_out, only: [:create]

  def create
    if env['omniauth.auth']['provider'] == 'identity'
      session[:teacher_id] = env['omniauth.auth']['uid']
      redirect_to root_url, notice: "Je bent nu ingelogd als beheerder."
    elsif env['omniauth.auth']['provider'] == 'facebook'
      @existing_student = Student.where(:facebook_id => env["omniauth.auth"]["uid"]).first
      if @existing_student
        session[:student_id] = @existing_student.id
        redirect_to root_url, notice: "Welkom terug, #{@existing_student.name}!"
      else
        @new_student = Student.create_from_omniauth(env["omniauth.auth"])
        if @new_student
          session[:student_id] = @new_student.id
          redirect_to root_url, notice: "Welkom bij ICA Presents, #{@new_student.name}!"
        else
          redirect_to root_url, notice: "Sorry, er ging iets fout bij je aanmelding."
        end
      end
    end
  end

  def destroy
    if session[:student_id]
      session[:student_id] = nil
    elsif session[:teacher_id]
      session[:teacher_id] = nil
    end
    redirect_to root_url, notice: "Tot ziens!"
  end

  def error
    redirect_to root_url, notice: "Sorry, er ging iets fout bij je aanmelding."
  end
end
