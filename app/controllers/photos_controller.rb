class PhotosController < ApplicationController
    before_action :set_photo, only: [:show, :update, :destroy]
    before_action :authenticate_user!, only: [:create, :update]
    before_action :is_current?, only: [ :update, :destroy ]
    before_action :is_private?, only: [ :show ]
  
    # GET /photos
    def index
      render json: Photo.all.with_attached_picture.order(id: :desc)
    end
  
    # GET /photos/1
    def show
      render json: @photo
    end
  
    # POST /photos
    def create
      @photo = Photo.new()
      @photo.user = current_user
      @photo.picture.attach(params[:picture])

  
      if @photo.save
        render json: @photo, status: :created, location: @photo
      else
        render json: @photo.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /photos/1
    def update
      if @article.update(article_params)
        render json: @photo
      else
        render json: @photo.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /photos/1
    def destroy
      @photo.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_photo
        @photo = Photo.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def photo_params
        params.require(:photo).permit(:private)
      end
  
      def is_current?
        @photo = Photo.find(params[:id])
        unless current_user == @photo.user
          render json: @photo.errors, status: :unauthorized
        end
      end
  
      def is_private?
        @photo = Photo.find(params[:id])
        if current_user != @photo.user && @photo.private == true
          render json: @photo.errors, status: :unauthorized
        end
      end
  
end
