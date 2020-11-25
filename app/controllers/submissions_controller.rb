class SubmissionsController < ApplicationController
  def create 
    @submission = Submission.new(user_id: params[:user_id], exercise_id: params[:exercise_id])
    @submission.file.attach(io: File.open(params[:file].tempfile), filename:params[:file].original_filename)
    @submission.save
    redirect_to course_lecture_path(params[:course_id], params[:lecture_id])
  end

  def submission_params
    params.require(:submission).permit(:user_id, :exercise_id, :file)
  end
end
