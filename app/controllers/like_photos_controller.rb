class LikePhotosController < ApplicationController
  def create
    @like_photo = current_user.like_photos.new(like_params)
    if !@like_photo.save
      flash[:notice] = @like_photo.errors.full_messages.to_sentence
    end
    redirect_to(request.referrer || root_path)
  end
  def destroy
    @like_photo = current_user.like_photos.find(params[:id])
    @like_photo.destroy
    redirect_to(request.referrer || root_path)

  end
  private
  def like_params
    params.require(:like_photo).permit(:photo_id)
  end
end
