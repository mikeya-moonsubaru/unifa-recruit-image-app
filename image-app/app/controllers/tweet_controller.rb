class TweetController < ApplicationController
  def create
    text = "タイトル: #{params[:title]}"
    image_url = "http://localhost:3000/images/1.jpg"
    url = "#{ENV.fetch("TWEET_BASE_URL")}/api/tweets"
    access_token = Current.user.user_connection.tweet_access_token

    response = Faraday.post(url) do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{access_token}"
      req.body = {
        text: text,
        image_url: image_url,
      }.to_json
    end

    if response.status != 201
      raise "Failed to tweet: #{response.body}"
    end

    redirect_to root_path, notice: "ツイートしました"
  end
end
