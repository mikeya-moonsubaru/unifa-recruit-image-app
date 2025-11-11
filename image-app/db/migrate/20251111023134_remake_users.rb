class RemakeUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :email_address
    remove_column :users, :password_digest

    create_table :user_credentials do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email_address, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
