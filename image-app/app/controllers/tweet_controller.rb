class TweetController < ApplicationController
  def create
    image = Image.find(params[:image_id])
    text = image.title
    image_url = image.display_url
    url = "#{ENV.fetch("TWEET_BASE_URL")}/api/tweets"
    access_token = Current.user.user_connection.tweet_access_token

    response = Faraday.post(url) do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{access_token}"
      req.body = {
        text: text,
        url: image_url,
      }.to_json
    end

    if response.status != 201
      raise "Failed to tweet: #{response.body}"
    end

    redirect_to root_path, notice: "ツイートしました"
  end
end
