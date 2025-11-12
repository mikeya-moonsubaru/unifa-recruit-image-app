require "rails_helper"

RSpec.describe Images::CreateUsecase do
  describe '#call' do
    subject { described_class.new(user, params) }

    let!(:user) { create(:user) }
    let!(:params) { { title: "Test Image", file: file } }
    let!(:file) { fixture_file_upload(Rails.root.join("spec/fixtures/test.jpg"), "image/jpeg") }

    context "正常系" do
      it "写真をアップロードする" do
        expect(subject.call).to eq(:ok)
        expect(user.images).to match_array([
          have_attributes(title: "Test Image"),
        ])
      end
    end

    context "バリデーションエラー: 「タイトル」が未入力の場合" do
      let!(:params) { { title: "", file: file } }
      it "エラーになる" do
        expect(subject.call).to eq(:error)
      end
    end

    context "バリデーションエラー: 「画像」が未選択の場合" do
      let!(:params) { { title: "Test Image", file: nil } }
      it "エラーになる" do
        expect(subject.call).to eq(:error)
      end
    end

    context "バリデーションエラー: 「タイトル」の文字数が30文字を超えている場合" do
      let!(:params) { { title: "a" * 31, file: file } }
      it "エラーになる" do
        expect(subject.call).to eq(:error)
      end
    end
  end
end
