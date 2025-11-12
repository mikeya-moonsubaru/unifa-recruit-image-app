require "rails_helper"

RSpec.describe TweetController, type: :controller do
  describe "POST #create" do
    let!(:user) { create(:user, :with_connection) }
    let!(:image) { create(:image, user: user) }

    before do
      session = user.sessions.create!
      cookies.signed.permanent[:session_id] = { value: session.id }

      stub_request(:post, "#{ENV.fetch("TWEET_BASE_URL")}/api/tweets").
        to_return(status: 201, body: {}.to_json)
    end

    it "ツイートする" do
      post :create, params: { image_id: image.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("ツイートしました")
    end
  end
end
