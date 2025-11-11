class UserCredential < ApplicationRecord
  belongs_to :user

  has_secure_password

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
