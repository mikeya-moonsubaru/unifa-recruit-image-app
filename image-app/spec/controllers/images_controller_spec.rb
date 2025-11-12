require "rails_helper"

RSpec.describe ImagesController, type: :controller do
  let!(:user) { create(:user) }

  before do
    session = user.sessions.create!
    cookies.signed.permanent[:session_id] = { value: session.id }
  end

  describe "POST #create" do
    let!(:file) { fixture_file_upload(Rails.root.join("spec/fixtures/test.jpg"), "image/jpeg") }

    it "creates a new image" do
      post :create, params: { image: { title: "Test Image", file: file } }
      expect(response).to redirect_to(root_path)
    end
  end
end
