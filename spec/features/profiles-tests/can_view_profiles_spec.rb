require 'rails_helper'

RSpec.feature 'View Profile', type: :feature do
  scenario 'Can see a list of all active profiles' do
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
  end

  scenario 'Can click and view others profiles' do
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
    expect(page).to have_content('User Profiles')
    click_on 'Kit TheDog'
    expect(page).to have_content('Im a dog!')
  end

  scenario 'Upon clicking, shows the details of their profile and posts' do
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
    visit '/posts'

    fill_in 'post[message]', with: 'Hello, world!'
    click_on 'Post'
    visit '/posts'
    expect(page).to have_content('Hello, world!')
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
    expect(page).to have_content('User Profiles')
    click_on 'Kit TheDog'
    expect(page).to have_content('Im a dog!')
    expect(page).to have_content('Bark!')
  end 
end