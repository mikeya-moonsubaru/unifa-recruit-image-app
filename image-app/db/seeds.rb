# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.where(id: [1,2,3]).destroy_all
User.create(id: 1, email_address: "dev@example.com", password: "password1")
User.create(id: 2, email_address: "dev2@example.com", password: "password2")
User.create(id: 3, email_address: "dev3@example.com", password: "password3")
