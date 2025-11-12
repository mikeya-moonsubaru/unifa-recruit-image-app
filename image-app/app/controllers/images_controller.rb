class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    permitted_params = params.require(:image).permit(:title, :file)
    result = Images::CreateUsecase.new(Current.user, permitted_params).call

    if result == :ok
      redirect_to root_path, notice: "写真をアップロードしました"
    else
      # TODO: サーバサイドエラーハンドリング
      render :new, status: :unprocessable_entity
    end
  end
end
