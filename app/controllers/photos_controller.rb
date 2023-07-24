class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]

  # GET /photos or /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1 or /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos or /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    respond_to do |format|
      if @photo.save
        format.html { redirect_to user_path(current_user, mode: "photos"), notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html do
          if !current_user.is_admin
            redirect_to user_path(current_user, mode: "photos"), notice: "Photo was successfully updated."
          else
            redirect_to admin_index_path(mode: "photo"), notice: "Photo was successfully updated."
          end
        end
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    if params[:mode] == "delete_for_album"
      @photo.destroy
      redirect_to edit_album_path(id:params[:album_id]), notice: "Photo was successfully destroyed"
    else
      @photo.destroy
      respond_to do |format|
        format.html do
          if !current_user.is_admin
            redirect_to user_path(current_user, mode: "photos"), notice: "Photo was successfully destroyed."
          else
            redirect_to admin_index_path(mode: "photo"), notice: "Photo was successfully destroyed."
          end
        end
        format.json { head :no_content }
        format.js   { render layout: false }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:title,:description,:image,:sharing_status)
    end
end
