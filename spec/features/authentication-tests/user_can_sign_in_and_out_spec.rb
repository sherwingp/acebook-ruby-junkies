# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signing in and out', type: :feature do
  scenario 'User can sign in and sign out' do
    visit '/users/sign_up'
    fill_in 'user[name]', with: 'John'
    fill_in 'user[surname]', with: 'Doe'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'

    fill_in 'profile_about', with: 'Im a cat!'
    click_button 'Create Profile'

    click_link('Sign Out')
    visit '/users/sign_in'

    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'

    expect(page).to have_content('Logged in successfully')
  end
end
