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

element = Element.new(
  name: "Banner",
  css_code: '.banner {
  background-size: cover;
  background-position: center;
  padding: 150px 0;
}

.banner h1 {
  margin: 0;
  color: white;
  text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
  font-size: 32px;
  font-weight: bold;
}

.banner p {
  font-size: 20px;
  color: white;
  opacity: .7;
  text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
}',
  html_code: '<div class="banner" style="background-image: linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,0.4)), url(https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/background.png);">
  <div class="container">
    <h1>Le Wagon brings <strong>tech skills</strong> to <strong>creative people</strong>!</h1>
    <p>Change your life and learn to code at one of our campuses around the world.</p>
    <a class="btn btn-flat" href="#">Apply now</a>
  </div>
</div>',
  theme: theme
)
element.save!

element = Element.new(
  name: "Card Category",
  css_code: '.card-category {
  background-size: cover;
  background-position: center;
  height: 180px;
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  font-size: 24px;
  font-weight: bold;
  text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
  border-radius: 5px;
  box-shadow: 0 0 15px rgba(0,0,0,0.2);
}',
  html_code: '<div class="card-category" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url(https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/breakfast.jpg)">
  Breakfast
</div>',
  theme: theme
)
element.save!
