require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"

    visit "/posts"
    # click_link "What's on your mind?"
    fill_in "post[message]", with: "Hello, world!"
    click_button "Create Post"
    expect(page).to have_content("Hello, world!")
    #Database has username as name
    expect(page).to have_content("John Doe")
  end

  scenario "should have an image once an image post is made" do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
		
    visit "/posts"
    fill_in "post[message]", with: "Hello, world!"
    attach_file('post[image]',
                File.join(Rails.root, '/spec/feature_test_image1.jpeg'), :visible => false)
    click_button "Create Post"
    expect(page).to have_css("img[src*='/feature_test_image1.jpeg']")
  end
end
