class AddIndexEmailUniq < ActiveRecord::Migration[8.1]
  def change
    add_index :user_credentials, :email_address, unique: true
  end
end
