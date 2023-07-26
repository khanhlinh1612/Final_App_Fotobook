class DiscoverController < ApplicationController

  def index
    @mode = params[:mode].presence || "PHOTO"

    if user_signed_in?
      if @mode == "PHOTO"
        @posts = Photo.all.where(sharing_status: "shared", album_id: nil)
      else
        @posts = Album.all.where(sharing_status: "shared")
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
