class RelationshipsController < ApplicationController
  before_action :relationship_params, only: [:create]
  def create
    @relationships = current_user.active_relationships.new(relationship_params)
    if !@relationships.save
      flash[:notice] = @relationships.errors.full_messages.to_sentence
    else
      flash[:success] = "You have successfully followed."
    end
      redirect_to request.referrer
  end
  def destroy
    @relationship = current_user.active_relationships.find(params[:id])
    if !@relationship.destroy
      flash[:notice] = @relationship.errors.full_messages.to_sentence
    else
      flash[:success] = "You have successfully unfollowed."
    end
    redirect_to request.referrer
  end

  private
  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end
end
