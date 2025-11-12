class TweetController < ApplicationController
  def create
    Tweet::CreateForImageUsecase.new(Current.user, params[:image_id]).call

    redirect_to root_path, notice: "ツイートしました"
  end
end
