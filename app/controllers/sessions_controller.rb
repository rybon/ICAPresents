class SessionsController < ApplicationController
  before_action :check_logged_out, only: [:create]

  def create
    if env['omniauth.auth']['provider'] == 'identity'
      session[:teacher_id] = env['omniauth.auth']['uid']
      redirect_to root_url, notice: "You're now logged in as administrator."
    elsif env['omniauth.auth']['provider'] == 'facebook'
      @existing_student = Student.where(:facebook_id => env["omniauth.auth"]["uid"]).first
      if @existing_student
        session[:student_id] = @existing_student.id
        redirect_to root_url, notice: "Welcome back, #{@existing_student.name}!"
      else
        @new_student = Student.create_from_omniauth(env["omniauth.auth"])
        if @new_student
          session[:student_id] = @new_student.id
          redirect_to root_url, notice: "Welcome to ICA Presents, #{@new_student.name}!"
        else
          redirect_to root_url, notice: "Sorry, something went wrong."
        end
      end
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Goodbye!"
  end

  def error
    reset_session
    redirect_to root_url, notice: "Sorry, something went wrong."
  end
end
