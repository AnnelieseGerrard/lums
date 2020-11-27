class CoursesController < ApplicationController
  def index
    if current_user.is_creator
      @courses = current_user.courses_created
    else
      @courses = current_user.courses_enrolled
    end
  end
  def show
    @course = Course.find(params[:id])
  end
end
