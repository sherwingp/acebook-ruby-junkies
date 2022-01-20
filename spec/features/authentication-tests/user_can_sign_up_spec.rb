require 'rails_helper'

RSpec.feature "Signing up", type: :feature do
  scenario "User can sign up" do
    visit "/users/sign_up"

		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
		
		expect(page).to have_content("GemJunkies Welcome! You have signed up successfully. John Sign Out")
  end
end
