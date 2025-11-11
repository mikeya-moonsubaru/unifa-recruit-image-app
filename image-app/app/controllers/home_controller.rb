class HomeController < ApplicationController
  def index
    @images = Current.user.images.order(created_at: :desc, id: :desc)
  end
end
