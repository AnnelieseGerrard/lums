class LecturesController < ApplicationController
  def show
    @lecture = Lecture.find(params[:id])
  end

  # GET courses/:course_id/lectures/new(.:format)
  def new
    @lecture = Lecture.new
    @course = Course.find(params[:course_id])
  end

  # POST courses/:course_id/lectures(.:format)
  def create
    @lecture = Lecture.new(lecture_params)
    @course = Course.find(params[:course_id])
    @lecture.course = @course
    if @lecture.save
      redirect_to course_path(@course), notice: 'Lecture successfully created.'
    else
      render :new
    end
  end

  private

  def lecture_params
    params.require(:lecture).permit(:title, :description, :video, resources: [])
  end
end
