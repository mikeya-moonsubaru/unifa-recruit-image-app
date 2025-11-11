class CreateUserConnections < ActiveRecord::Migration[8.1]
  def change
    create_table :user_connections do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.string :tweet_access_token
    end
  end
end
