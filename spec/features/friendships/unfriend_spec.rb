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
    visit '/users/profiles'
    expect(page).to have_content('User Profiles')
    click_on 'name'
    click_on 'Add Friend'
    click_on 'Sign Out'
    login_as(@user1, :scope => :user)
    visit('/friend_requests')
    click_on 'Accept Request'
  end
  
  scenario "a user can see their list of friends on their profile" do
    visit '/users/profiles'
    expect(page).to have_content('Friends')
    click_on 'Kit TheDog'
    expect(page).to have_content('name surname')
    click_on 'Unfriend'
    visit '/users/profiles'
    click_on 'name'
    expect(page).not_to have_content('Kit TheDog')
    visit '/users/profiles'
    click_on 'Kit TheDog'
    expect(page).not_to have_content('name surname')  
  end
end