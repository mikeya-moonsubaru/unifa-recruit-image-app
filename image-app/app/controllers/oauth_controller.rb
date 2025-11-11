class OauthController < ApplicationController
  CALLBACK_URL = "http://localhost:3000/oauth/callback"

  def tweet_authorize
    url = "#{ENV.fetch("TWEET_BASE_URL")}/oauth/authorize"
    client_id = ENV.fetch("OAUTH_CLIENT_ID")
    response_type = "code"
    redirect_uri = CALLBACK_URL
    scope = "write_tweet"

    redirect_to "#{url}?client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=#{response_type}&scope=#{scope}",
      allow_other_host: true
  end

  def callback
    code = params[:code]
    client_id = ENV.fetch("OAUTH_CLIENT_ID")
    client_secret = ENV.fetch("OAUTH_CLIENT_SECRET")
    redirect_uri = CALLBACK_URL
    url = "#{ENV.fetch("TWEET_BASE_URL")}/oauth/token"

    response = Faraday.post(url) do |req|
      req.headers["Content-Type"] = "application/json"

      req.body = {
        grant_type: "authorization_code",
        code: code,
        client_id: client_id,
        client_secret: client_secret,
        redirect_uri: redirect_uri,
      }.to_json
    end

    if response.status != 200
      raise "Failed to get access token: #{response.body}"
    end

    @access_token = JSON.parse(response.body)["access_token"]
    session[:tweet_access_token] = @access_token
    redirect_to root_path
  end
end
