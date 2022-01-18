require 'rails_helper'

RSpec.feature "Signing in", type: :feature do
  scenario "User can sign in" do

		visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
		
    click_button "Sign Out"

    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
    click_button "Log in"
		
		expect(page).to have_content("Signed in as: John")
		expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
