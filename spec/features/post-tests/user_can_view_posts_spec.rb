# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Post content', type: :feature do
  before(:each) do
    visit '/users/sign_up'
    fill_in 'user[name]', with: 'Kitty'
    fill_in 'user[surname]', with: 'TheCat'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'

    visit '/posts'
    fill_in 'post[message]', with: 'Meow!'
    attach_file('post[image]',
                File.join(Rails.root, '/spec/feature_test_image1.jpeg'), visible: false)
    click_button 'Create Post'
  end

  scenario 'it displays the post details' do
    expect(page).to have_content('Meow!')
    expect(page).to have_content(Time.zon.today)
    expect(page).to have_content('Kitty TheCat')
    expect(page).to have_css("img[src*='/feature_test_image1.jpeg']")
  end

  scenario 'posts appear with the newest post first' do
    fill_in 'post[message]', with: 'First Post!'
    click_button 'Create Post'

    fill_in 'post[message]', with: 'Second Post!'
    click_button 'Create Post'

    # page.body.index('This').should < page.body.index('That')
    # puts (page.body.index("post_2") < page.body.index("post_1"))
    # expect(first(".post")).to have_content("Second Post!")
    # expect(page).to have_content("First Post!")
    time = (Time.zone.now.to_s).split('.')[0].split
    time_string = "#{time[0]} #{time[1]}"
    expect(page).to have_content('Second Post! Second Post!')
    expect(page).to have_content('Comments go here :D 0 Likes Comments')
    expect(page).to have_content("Add a comment: Body Image Kitty TheCat #{time_string} UTC")
    expect(page).to have_content('First Post! First Post!')
  end
end
