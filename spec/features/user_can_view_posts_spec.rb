require 'rails_helper'

RSpec.feature "Post content", type: :feature do
  before(:each) do
    # # will need to revisit after merge
    # visit "/sign-up"
    # fill_in "email", with: "test@gmail.com"
    # fill_in "password", with: "randompswd"
    # fill_in "validate_password", with: "randompswd"
    # fill_in "first_name", with: "Kitty"
    # fill_in "last_name", with: "TheCat"
    # click_button "Submit"
    # redirected to log in page
    # fill_in "email", with: "test@gmail.com"
    # fill_in "password", with: "randompswd"
    # fill_in "validate_password", with: "randompswd"
    # click_button "Submit"
    # redirected to post page as logged in user

    visit("/posts")
    click_link "What's on your mind?"
    fill_in "Message", with: "Meow!"
    # attach_file "Image", "/winking-cat.jpg"
    click_button "Submit"
  end

  scenario "it displays the post details" do
    expect(page).to have_content("Meow!")
    expect(page).to have_content(Date.today)
    expect(page).to have_content("Kitty TheCat")
    expect(page).to have_xpath("//img[contains(@src,'winking-cat.jpg')]")
  end

  scenario "posts appear with the newest post first" do
    click_link "What's on your mind?"
    fill_in "Message", with: "I'm posting this first"
    click_button "Submit"

    click_link "What's on your mind?"
    fill_in "Message", with: "I'm posting this second"
    click_button "Submit"

    expect(first(".post")).to have_content("I'm posting this second")
  end
end