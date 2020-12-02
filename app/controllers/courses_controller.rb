class CoursesController < ApplicationController
  load_and_authorize_resource
  def index
    if current_user.is_creator
      @courses = current_user.courses_created
    else
      @courses = current_user.courses_enrolled
    end
  end
  def show
    @course = Course.find(params[:id])
    if cannot? :read, @course
      flash[:alert] = "You are not enrolled in that course."
      redirect_to courses_path
    else
      redirect_to course_lecture_path(@course, @course.lectures.first)
    end
  end
end
