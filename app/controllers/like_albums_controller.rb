class LikeAlbumsController < ApplicationController
  def create
    @like_album = current_user.like_albums.new(like_params)
    if !@like_album.save
      flash[:notice] = @like_album.errors.full_messages.to_sentence
    end
    redirect_to(request.referrer || root_path)
  end
  def destroy
    @like_album = current_user.like_albums.find(params[:id])
    @like_album.destroy
    redirect_to(request.referrer || root_path)

  end
  private
  def like_params
    params.require(:like_album).permit(:album_id)
  end
end
