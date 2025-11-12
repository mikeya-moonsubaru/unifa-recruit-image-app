module Tweet
  class CreateForImageUsecase
    def initialize(user, image_id)
      @user = user
      @image_id = image_id
    end

    def call
      image = Image.find(@image_id)
      text = image.title
      image_url = image.display_url
      create_tweet(@user, text, image_url)

      :ok
    end

    private

    def create_tweet(user, text, image_url)
      url = "#{ENV.fetch("TWEET_BASE_URL")}/api/tweets"
      access_token = user.user_connection.tweet_access_token

      response = Faraday.post(url) do |req|
        req.headers["Content-Type"] = "application/json"
        req.headers["Authorization"] = "Bearer #{access_token}"
        req.body = {
          text: text,
          url: image_url,
        }.to_json
      end

      if response.status != 201
        # TODO: エラーハンドリングとエラー出力調整
        raise "Failed to tweet: #{response.body}"
      end

      response
    end
  end
end
