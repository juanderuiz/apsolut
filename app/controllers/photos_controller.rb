class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :destroy]

  def index
  	@photos = Photo.all.order(id: :desc)
    @photoxs = @photos
    @total = @photos.count()
  end

  def allimages
    @photos = Photo.all.order(id: :desc)
    @total = @photos.count()
  end

  def alert
    @photo = Photo.find(params[:photo_id])
  end

  def new
    @photo = Photo.new
    @photos = Photo.limit(3).order(id: :desc)
    @total = Photo.all.count()
    #number of images to show in below the upload form
    @inicio = @photos.count()
  end

  def show
  	#Enough with the before_action set_photo
  end

  def create
  	@photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to new_photo_path, notice: 'Foto subida!.' }
        #format.json { render action: 'show', status: :created, location: @runner }
      else
      	#flash.alert = "Error!"
        #format.html { render action: 'new' }
        format.html { redirect_to new_photo_path }
        #format.json { render json: @runner.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #@photo = Photo.find(params[:id])
    respond_to do |format|
      if @photo.destroy
        format.html { redirect_to new_photo_path, notice: 'Foto eliminada!.' }
      else
        format.html { redirect_to new_photo_path }
      end
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      #params.require(:photo).permit(:image)
      params.fetch(:photo, {}).permit(:image)
    end
end
