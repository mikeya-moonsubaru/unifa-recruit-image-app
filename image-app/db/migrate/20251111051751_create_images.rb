class CreateImages < ActiveRecord::Migration[8.1]
  def change
    create_table :images do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :path, null: false
    end
  end
end
