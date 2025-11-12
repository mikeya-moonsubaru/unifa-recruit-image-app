require "rails_helper"

RSpec.describe Tweet::CreateForImageUsecase do
  describe '#call' do
    subject { described_class.new(user, image.id) }

    let!(:user) { create(:user, :with_connection) }
    let!(:image) { create(:image, user: user) }

    context "正常系" do
      it "ツイートする" do
        stub = stub_request(:post, "#{ENV.fetch("TWEET_BASE_URL")}/api/tweets").
          with(body: { text: image.title, url: image.display_url }.to_json).
          to_return(status: 201, body: {}.to_json)

        expect(subject.call).to eq(:ok)
        expect(stub).to have_been_requested
      end
    end

    context "異常系: レスポンスがエラーの場合" do
      it "エラーになる" do
        stub = stub_request(:post, "#{ENV.fetch("TWEET_BASE_URL")}/api/tweets").
          to_return(status: 400, body: {}.to_json)

        expect { subject.call }.to raise_error("Failed to tweet: #{stub.response.body}")
        expect(stub).to have_been_requested
      end
    end
  end
end
