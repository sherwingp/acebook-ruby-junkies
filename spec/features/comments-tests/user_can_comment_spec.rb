# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Commenting', type: :feature do
  scenario 'Can comment on a post' do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
    visit "/posts/new"
    fill_in "post[message]", with: "Hello, world!"
    click_button "Post"
    expect(page).to have_content("Hello, world!")
    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Comment"
    visit '/posts'
    expect(page).to have_content('A comment!')
  end

  scenario 'Can comment on a post and it will show your name' do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
    visit "/posts/new"
    fill_in "post[message]", with: "Hello, world!"
    click_button "Post"
    expect(page).to have_content("Hello, world!")
    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Comment"
    visit '/posts'
    expect(page).to have_content('John Doe A comment!')
  end

  scenario 'User can add a photo to their comment' do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
    visit "/posts/new"
    fill_in "post[message]", with: "Hello, world!"
    click_button "Post"
    expect(page).to have_content("Hello, world!")
    visit '/posts'
    fill_in 'comment[body]', with: 'A comment!'
    attach_file('comment[image]',
      File.join(Rails.root, '/spec/feature_test_image1.jpeg'), :visible => false)
    click_button "Comment"
    expect(page).to have_css("img[src*='/feature_test_image1.jpeg']")
  end
end
