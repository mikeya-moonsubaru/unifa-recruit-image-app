module Images
  class CreateUsecase
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      title = @params[:title]

      file = @params[:file]
      file_name = file.original_filename
      path = "#{SecureRandom.uuid}.#{file_name.split('.').last}"
      # NOTE: 画像公開状態
      full_path = "#{Rails.root}/public/images/#{@user.id}/#{path}"

      FileUtils.mkdir_p(File.dirname(full_path))
      File.binwrite(full_path, file.read)

      @image = @user.images.create!(path: path, title: title)
      @image.save!

      :ok
    end
  end
end
