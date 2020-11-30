class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @courses = Course.all
  end

  def error_404
  end
end
