class FeedController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # render json: params
    if params[:mode].present?
      @mode = params[:mode]
    else
      @mode = "PHOTO"
    end

    if user_signed_in?
      if @mode == "PHOTO"
        @posts = Photo.where(user_id: current_user.id).order(created_at: :desc)
      else
        @posts = Album.where(user_id: current_user.id).order(created_at: :desc)
      end
    else
      if @mode == "PHOTO"
        @posts = Photo.where(sharing_status: "shared").order(created_at: :desc)
      else
        @posts = Album.where(sharing_status: "shared").order(created_at: :desc)
      end
    end
  end


end
