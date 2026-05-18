# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Cleaning my DB...."
Theme.destroy_all
User.destroy_all

user = User.new(
  email: "test@test.com",
  password: "111111"
)
user.save

theme = Theme.new(
  name: "Early 2000s",
  specs: "Placeholder specs, when we test the AI these should be updated",
  user: user
)
theme.save

theme = Theme.new(
  name: "My landing page",
  specs: "Placeholder specs, when we test the AI these should be updated",
  user: user
)
theme.save

theme = Theme.new(
  name: "Minimalist",
  specs: "Placeholder specs, when we test the AI these should be updated",
  user: user
)
theme.save

theme = Theme.new(
  name: "Pizza restaurant",
  specs: "Placeholder specs, when we test the AI these should be updated",
  user: user
)
theme.save
