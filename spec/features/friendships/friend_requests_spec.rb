# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Friend Request", type: :feature do
  before(:each) do
    @user1 = FactoryBot.create(:user)
    login_as(@user1, :scope => :user)
    visit '/'
    fill_in 'profile_about', with: 'Im a cat!'
    click_button 'Create Profile'
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
  end

  scenario "can send a friend request from the profile" do
    visit '/users/profiles'
    expect(page).to have_content('User Profiles')
    click_on 'name'
    click_on 'Add Friend'
    expect(page).to have_content('Friend request already sent!')
  end

  scenario "can send a friend request from the list of profiles page" do
    visit '/users/profiles'
    click_on 'Add Friend'
    expect(page).to have_content('Friend request already sent!')
  end

  scenario "cannot send a friend request to someone who has sent you a friend request" do
    visit '/users/profiles'
    click_on 'Add Friend'
    click_on 'Sign Out'
    login_as(@user1, :scope => :user)
    visit '/users/profiles'
    expect(page).to have_content('User Profiles')
    expect(page).to have_content('Pending Request')
    click_on 'Kit TheDog'
    expect(page).to have_content('Pending Request')
  end

  scenario "cannot send a friend request to yourself" do
    expect(page).not_to have_content('Add Friend')
  end
end