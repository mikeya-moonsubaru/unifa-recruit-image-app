module Images
  class CreateUsecase
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      validate_params

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

    private

      # 画面でチェックしているので通常はエラーにならない
      def validate_params
        if @params[:title].blank?
          raise "タイトルが未入力です"
        end

        if @params[:file].blank?
          raise "画像が未選択です"
        end

        if @params[:title].length > 30
          raise "タイトルは30文字以内で入力してください"
        end
      end
  end
end
