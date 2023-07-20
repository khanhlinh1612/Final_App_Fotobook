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
      @user_followings = current_user.active_relationships.pluck(:followed_id)
      if @mode == "PHOTO"
        @posts = Photo.where(user_id: @user_followings).where(sharing_status: "shared").where(album_id: nil).order(created_at: :desc)
      else
        @posts = Album.where(user_id: @user_followings).where(sharing_status: "shared").order(created_at: :desc)
      end
    else
      if @mode == "PHOTO"
        @posts = Photo.where(sharing_status: "shared").where(album_id: nil).order(created_at: :desc)
      else
        @posts = Album.where(sharing_status: "shared").order(created_at: :desc)
      end
    end
  end


end
