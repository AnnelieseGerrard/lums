class CoursesController < ApplicationController
  def show
    @course_id = params[:id]
    @lecture = Lecture.new
  end
end
