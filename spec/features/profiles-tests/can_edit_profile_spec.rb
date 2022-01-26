require 'rails_helper'

RSpec.feature 'Edit Profile', type: :feature do
  scenario 'Can edit your own profile' do
    visit '/users/sign_up'
    fill_in 'user[name]', with: 'Kitty'
    fill_in 'user[surname]', with: 'TheCat'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content('Create Profile')
    fill_in 'profile_about', with: 'Im a cat!'
    click_button 'Create Profile'
    click_on 'Edit Profile'
    fill_in 'profile_about', with: 'Im not a cat!'
    click_button 'Edit Profile'
    expect(page).to have_content('Im not a cat!')
  end


  scenario 'Cannot edit others profiles' do
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
    click_on 'Sign Out'

    visit '/users/sign_up'
    fill_in 'user[name]', with: 'Kitty'
    fill_in 'user[surname]', with: 'TheCat'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content('Create Profile')
    fill_in 'profile_about', with: 'Im a cat!'
    click_button 'Create Profile'
    visit '/'
    visit '/users/profiles'
    expect(page).to have_content('Kit TheDog')
    click_on 'Kit TheDog'
    expect(page).not_to have_content('Edit Profile')

  end 
end