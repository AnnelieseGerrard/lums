class LecturesController < ApplicationController
   # GET courses/:course_id/lectures/new(.:format)
  load_and_authorize_resource

  def new
    @lecture = Lecture.new
    @exercise = Exercise.new
    @course = Course.find(params[:course_id])
  end
  
  # POST courses/:course_id/lectures(.:format)
  def create
    @lecture = Lecture.new(lecture_params)
    @course = Course.find(params[:course_id])
    @lecture.course = @course
    @exercise = Exercise.new(exercise_params)
    @lecture.exercise = @exercise
    if @lecture.valid? && @exercise.valid?
      @lecture.save
      redirect_to course_lecture_path(@course, @lecture), notice: 'Lecture successfully created.'
    else
      render :new
    end
  end
  
  def show
    @course = Course.find(params[:course_id])

    @lecture = Lecture.find(params[:id])
    if params[:query].present?
      @lectures = Lecture.where(course_id: @course.id).search_by_title_and_description(params[:query])
    else
      @lectures = Lecture.where(course_id: @course.id)
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @lecture = Lecture.find(params[:id])
    @exercise = @lecture.exercise
  end

  def update
    @lecture = Lecture.find(params[:id])
    @exercise = @lecture.exercise
    @lecture.update(lecture_params)
    @exercise.update(exercise_params)
    redirect_to course_lecture_path(@lecture.course, @lecture, notice: 'Lecture successfully updated.')
  end

  def destroy
    @course = Course.find(params[:course_id])
    @lecture = Lecture.find(params[:id])
    @lecture.remove_from_list
    @lecture.destroy
    redirect_to course_lecture_path(@course, @course.lectures.first, notice: 'Lecture deleted.')
  end

  def move
    @lecture = Lecture.find(params[:id])
    @lecture.insert_at(params[:position].to_i)
  end

  private

  def lecture_params
    params.require(:lecture).permit(:title, :description, :video, exercise: [], resources: [])
  end

  def exercise_params
    params.require(:lecture).require(:exercise).permit(:name, :rich_description, :is_assessed)
  end
end
