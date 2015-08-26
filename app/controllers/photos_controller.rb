class PhotosController < ApplicationController
  before_action :set_photo, only: [:show]

  def index
  	@photos = Photo.limit(3).order(id: :desc)
    @total = @photos.count()
  	@photo = Photo.new
  end

  def show
  	#Enough with the before_action set_photo
  end

  def create
  	@photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Foto subida!.' }
        #format.json { render action: 'show', status: :created, location: @runner }
      else
      	flash.alert = "Error!"
        #format.html { render action: 'show' }
        #format.json { render json: @runner.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image)
    end
end
