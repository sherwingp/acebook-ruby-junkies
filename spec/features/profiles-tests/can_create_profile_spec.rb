require 'rails_helper'

RSpec.feature 'Create Profile', type: :feature do
  scenario 'Can create a profile upon signing up' do
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
    expect(page).to have_content("Kitty TheCat About: Im a cat! Photos: Friends")
  end

  scenario 'Nav bar vanishes when no profile exists as to force profile creation' do
    visit '/users/sign_up'
    fill_in 'user[name]', with: 'Kitty'
    fill_in 'user[surname]', with: 'TheCat'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content('Create Profile')
    expect(page).not_to have_content('Sign Out')
  end

  scenario 'Your profile exists once created' do
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
    click_on 'Gem Junkies Default Avatar'
    expect(page).to have_content("Kitty TheCat About: Im a cat! Photos: Friends")
  end 

  scenario 'Cannot go back to profile creation page once profile created' do
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
    expect(page).to have_content("Logged in successfully")
  end

  scenario 'NOT IMPLIMENTED: cannot redirect away unless a profile is created' do
  end

end