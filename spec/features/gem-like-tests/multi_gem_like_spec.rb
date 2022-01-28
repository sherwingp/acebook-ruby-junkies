# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "MultiGemLikes", type: :feature do

scenario "multiple users can gemlike a post, and this will add up on the posters profile page" do
  @user1 = FactoryBot.create(:user)
  login_as(@user1, :scope => :user)
  visit '/'
  fill_in 'profile_about', with: 'Im a cat!'
  click_button 'Create Profile'
 
  visit "/posts/new"
  fill_in "post[message]", with: "Hello, world!"
  click_on "Post"
  visit'/'
  click_on 'Give Gem!'


  click_on 'Sign Out'
  visit '/users/sign_up'
  fill_in 'user[name]', with: 'Kit'
  fill_in 'user[surname]', with: 'TheDog'
  fill_in 'user[email]', with: 'testing@test.com'
  fill_in 'user[password]', with: '123456'
  fill_in 'user[password_confirmation]', with: '123456'
  click_button 'Sign up'
  expect(page).to have_content('Create Profile')
  fill_in 'profile_about', with: 'Im a dog!'
  click_button 'Create Profile'
  visit'/'
  click_on 'Give Gem!'

  visit '/users/profiles'
  expect(page).to have_content('User Profiles')
  click_on 'name'
  expect(page).to have_content(2)
end

end