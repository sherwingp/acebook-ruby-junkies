require 'rails_helper'

RSpec.feature "Post content", type: :feature do
  before(:each) do
    visit "/users/sign_up"
		fill_in "user[name]", with: "Kitty"
		fill_in "user[surname]", with: "TheCat"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
		
    visit "/posts/new"
    fill_in "post[message]", with: "Meow!"
    attach_file('post[image]',
                File.join(Rails.root, '/spec/feature_test_image1.jpeg'), :visible => false)
    click_button "Post"
  end

  scenario "it displays the post details" do
    expect(page).to have_content("Meow!")
    expect(page).to have_content("Kitty TheCat")
    expect(page).to have_css("img[src*='/feature_test_image1.jpeg']")
  end

  scenario "posts appear with the newest post first" do
    visit "/posts/new"
    fill_in "post[message]", with: "First Post!"
    click_button "Post"

    visit "/posts/new"
    fill_in "post[message]", with: "Second Post!"
    click_button "Post"

    messages = page.all('p.display-message')
    expect(messages[0].text).to eq "Second Post!"
  end
end