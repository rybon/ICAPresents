class NewProjectMailer < ActionMailer::Base
  default to: Proc.new { Teacher.pluck(:email) }, from: "ICA Presents <no-reply@icapresents.nl>"

  def new_project_email(project)
    @title = project.title
    @author = project.author.name
    @semester = project.semester
    @students = project.students
    @url = "http://www.icapresents.nl/projects/#{project.id}/edit"
    mail(subject: "ICA Presents has a new project: #{@title}")
  end
end
