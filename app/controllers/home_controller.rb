class HomeController < ApplicationController
  def index
  end

  def display_image
     send_file(params[:file_name])
  end
end
