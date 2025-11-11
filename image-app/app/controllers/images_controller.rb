class ImagesController < ApplicationController
  def index
    @images = Current.user.images
  end
end
