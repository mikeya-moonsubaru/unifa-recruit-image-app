class ImagesController < ApplicationController
  def index
    @images = Current.user.images
  end

  def new
    @image = Image.new
  end

  def create
    Images::CreateUsecase.new(Current.user, params[:image]).call

    redirect_to root_path, notice: "写真をアップロードしました"
  end
end
