class AdminController < ApplicationController
  def index
    if params[:mode].present?
      @mode = params[:mode]
    else
      @mode = "photo"
    end

    if @mode == "photo"
      @pagy,@posts = pagy(Photo.all.where(album_id: nil), items: 12)
    elsif @mode == "album"
      @pagy,@posts = pagy(Album.all, items: 12)
    else
      @pagy, @posts = pagy(User.all.where(is_admin: false), items: 4)
    end
  end
end
