class FeedController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @mode = params[:mode].presence || "PHOTO"
    if user_signed_in?
      @user_followings = current_user.active_relationships.pluck(:followed_id)
        if @mode == "PHOTO"
          @posts = Photo.where(user_id: @user_followings).where(sharing_status: "shared").where(album_id: nil)
        else
          @posts = Album.where(user_id: @user_followings).where(sharing_status: "shared")
        end
    else
        if @mode == "PHOTO"
          @posts = Photo.where(sharing_status: "shared").where(album_id: nil).order(created_at: :desc)
        else
          @posts = Album.where(sharing_status: "shared").order(created_at: :desc)
        end

    end
    if params[:search] == "yes" && params[:key].present?
      key = "%#{params[:key].downcase}%"
      if @mode == "PHOTO"
        @posts = @posts.joins(:user).where("lower(photos.title) LIKE ? or lower(photos.description) LIKE ? or lower(users.first_name) LIKE ? or lower(users.last_name) LIKE ?", key, key, key, key)
      else
        @posts = @posts.joins(:user).where("lower(albums.title) LIKE ? or lower(albums.description) LIKE ? or lower(users.first_name) LIKE ? or lower(users.last_name) LIKE ?", key, key, key, key)
      end
    end
      @posts = @posts.order(created_at: :desc)
  end
end
