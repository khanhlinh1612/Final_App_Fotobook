class AlbumsController < ApplicationController
  before_action :set_album, only: %i[show update edit destroy]
  MAXPHOTO = 25

  # GET /albums or /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1 or /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    if params[:album_id].present?
      @album = Album.find(params[:album_id])
      @photos = @album.photos.where.not(id: nil)
      if @photos.size == MAXPHOTO
        @photo = @photos.last
        flash[:notice] = "Album should have at most 25 photo defined."
      else
        @photo = @album.photos.build
        @photo.title = @album.title
        @photo.description = @album.description
      end
      else
      @album = Album.new
      @photo = @album.photos.build
    end
  end

  # GET /albums/1/edit
  def edit
    @photos = @album.photos
    @photo = @album.photos.first
  end

  # POST /albums or /albums.json
  def create
    if params[:album_id].present?
      @album = Album.find(params[:album_id])
      if @album.photos.size < MAXPHOTO
        @album.photos.build(photo_params)
      end
    else
      @album = Album.new(album_params)
      @album.user_id = current_user.id
      @album.image = params[:album][:photos_attributes]['0'][:image]
    end

    if @album.save
      @album.photos.each do |photo|
        photo.album_id = @album.id
        photo.save
      end
      flash[:notice] = "Album was successfully created with #{@album.photos.size} photos."
      redirect_to new_user_album_path(current_user, album_id: @album.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if !params[:album][:image].blank?
        @album.photos.build(title: @album.title, album_id:@album.id,user_id: @album.user_id,description: @album.description, image: params[:album][:image])
      end
      if @album.update(album_edit)
        format.html { redirect_to edit_album_path(@album), notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit,  status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album.photos.each do |photo|
      photo.destroy
    end
    @album.destroy
    respond_to do |format|
      if current_user.is_admin
        format.html {redirect_to admin_index_path(mode: "album"), notice: "Album was successfully destroyed." }
      else
        format.html {redirect_to user_path(mode: "albums"), notice: "Album was successfully destroyed." }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(photos_attributes: [:id, :title, :description, :image, :user_id])
    end
    def album_edit
      params.require(:album).permit(:title, :description, :image)
    end
    def photo_params
      params.require(:photo).permit(:title,:description,:image,:sharing_status, :user_id)
    end
end
