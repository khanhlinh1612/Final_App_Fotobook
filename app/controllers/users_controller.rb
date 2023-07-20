class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if params[:mode].present?
      @mode = params[:mode]
    else
      @mode = "photos"
    end
    if @mode == "photos"
      if @user.id == current_user.id
        @posts = Photo.where(user_id: @user.id).where(album_id: nil).order(created_at: :desc)
      else
        @posts = Photo.where(user_id: @user.id,sharing_status:"shared").where(album_id: nil).order(created_at: :desc)
      end
    elsif @mode == "albums"
      if @user.id == current_user.id
        @posts = Album.where(user_id: @user.id).order(created_at: :desc)
      else
        @posts = Album.where(user_id: @user.id,sharing_status:"shared").order(created_at: :desc)
      end
      elsif @mode == "followings"
      @posts = User.where(id: @user.active_relationships.pluck(:followed_id))
    else
      @posts = User.where(id: @user.passive_relationships.pluck(:follower_id))
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(id:current_user.id, mode: "photos"), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params_change_password)
      bypass_sign_in @user, scope: :user
      redirect_to root_path, notice: "Password was successfully updated."
    else
      render "edit", status: :unprocessable_entity
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name,:last_name,:avatar,:email)
    end
    def user_params_change_password
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end
