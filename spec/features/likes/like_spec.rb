require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  scenario "a user can like a post and unlike a post" do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"

    visit '/posts/new'
    fill_in 'post[message]', with: 'I love Rails!'
    click_on 'Post'

    click_on 'Like'
    expect(page).to have_content '1 Like'
    click_on 'Unlike'
    expect(page).to have_content '0 Likes'
  end
end
