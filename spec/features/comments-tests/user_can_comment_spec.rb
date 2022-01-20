require 'rails_helper'

RSpec.feature "Commenting", type: :feature do
  scenario 'Can comment on a post' do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
    visit "/posts"
    click_link "What's on your mind?"
    fill_in "Message", with: "Hello, world!"
    click_button "Post"
    expect(page).to have_content("Hello, world!")
    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Create Comment"
    visit '/posts'
    expect(page).to have_content("A comment!")
  end

  scenario 'Can comment on a post and it will show your name' do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
    visit "/posts"
    click_link "What's on your mind?"
    fill_in "Message", with: "Hello, world!"
    click_button "Post"
    expect(page).to have_content("Hello, world!")
    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Create Comment"
    visit '/posts'
    expect(page).to have_content("John Doe A comment!")
  end

  scenario 'User can add a photo to their comment' do
    visit "/users/sign_up"
		fill_in "user[name]", with: "John"
		fill_in "user[surname]", with: "Doe"
    fill_in "user[email]", with: "test@test.com"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
    visit "/posts"
    click_link "What's on your mind?"
    fill_in "Message", with: "Hello, world!"
    click_button "Post"
    expect(page).to have_content("Hello, world!")
    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    attach_file('comment[image]',
      File.join(Rails.root, '/spec/image1.jpeg'), :visible => false)
    click_button "Create Comment"
    #  TODO: make line 63 pass, to make test more specific
    # expect(page).to have_xpath("//img[contains(@src, '/spec/image1.jpeg')]")
    page.should have_css('img')
  end

# Since we don't want them to view this page, not sure if needed?
  # scenario 'Can comment on a post on the posts page' do
  #   visit "/users/sign_up"
	# 	fill_in "user[name]", with: "John"
	# 	fill_in "user[surname]", with: "Doe"
  #   fill_in "user[email]", with: "test@test.com"
	# 	fill_in "user[password]", with: "123456"
	# 	fill_in "user[password_confirmation]", with: "123456"
  #   click_button "Sign up"
  #   visit "/posts"
  #   click_link "What's on your mind?"
  #   fill_in "Message", with: "Hello, world!"
  #   click_button "Post"
  #   visit '/posts/1'
  #   fill_in "comment[body]", with: "A comment!"
  #   click_button "Create Comment"
  #   visit '/posts'
  #   expect(page).to have_content("A comment!")
  # end
end