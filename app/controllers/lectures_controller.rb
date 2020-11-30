class LecturesController < ApplicationController

  def show
    @course = Course.find(params[:course_id])
    @lecture = Lecture.find(params[:id])
    if params[:query].present?
      @results = PgSearch.multisearch(params[:query])
      @lectures = @results.map do |result|
        if result.searchable.is_a?(Exercise)
          result.searchable.lecture
        else
          result.searchable
        end
      end
    else
      @lectures = Lecture.all
    end
  end

  # GET courses/:course_id/lectures/new(.:format)
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
    @lecture.description = params[:lecture][:description].gsub(/<[^>]+>/, "")
    @lecture.exercise = Exercise.new(name: params[:lecture][:exercise][:name],
                                     rich_description: params[:lecture][:exercise][:rich_description].gsub(/<[^>]+>/, ""),
                                     is_assessed: params[:lecture][:exercise][:is_assessed]
                                     )
    if @lecture.save
      redirect_to course_lecture_path(@course, @lecture), notice: 'Lecture successfully created.'
    else
      render :new
    end
  end

  def move
    @lecture = Lecture.find(params[:id])
    @lecture.insert_at(params[:position].to_i)
  end

  private

  def lecture_params
    params.require(:lecture).permit(:title, :description, :video, resources: [])
  end
end
