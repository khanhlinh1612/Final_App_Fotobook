class DiscoverController < ApplicationController

  def index
    # render json: params
    if params[:mode].present?
      @mode = params[:mode]
    else
      @mode = "PHOTO"
    end

    if user_signed_in?
      if @mode == "PHOTO"
        @posts = Photo.all.where(sharing_status: "shared").order(created_at: :desc)
      else
        @posts = Album.all.where(sharing_status: "shared").order(created_at: :desc)
      end
    end
  end


end
