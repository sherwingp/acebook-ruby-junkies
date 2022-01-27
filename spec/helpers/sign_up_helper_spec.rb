require 'rails_helper'

def sign_up
	visit "/users/sign_up"
	fill_in "user[name]", with: "John"
	fill_in "user[surname]", with: "Doe"
	fill_in "user[email]", with: "test@test.com"
	fill_in "user[password]", with: "123456"
	fill_in "user[password_confirmation]", with: "123456"
	click_button "Sign up"
	fill_in 'profile_about', with: 'Im a cat!'
  click_button 'Create Profile'
end