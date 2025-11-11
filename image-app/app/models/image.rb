class Image < ApplicationRecord
  belongs_to :user

  def display_url
    "http://localhost:3000/images/#{user.id}/#{path}"
  end
end
