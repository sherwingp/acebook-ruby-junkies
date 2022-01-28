# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "GemLikes", type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    post = FactoryBot.create(:post)
  end

  scenario "a user can gemlike a post" do
    visit '/'
    fill_in 'profile_about', with: 'Im a cat!'
    click_button 'Create Profile'

    visit '/posts'
    click_on 'Give Gem!'
    expect(has_css?('i.fa-gem', count: 1)).to eq true
  end

  scenario "a user can unlike a post" do
    visit '/'
    fill_in 'profile_about', with: 'Im a cat!'
    click_button 'Create Profile'

    visit '/posts'
    click_on 'Give Gem!'

    click_on 'Remove Gem'
    expect(has_css?('i.fa-gem', count: 0)).to eq true
  end

  scenario "a user can like a comment" do
    visit '/'
    fill_in 'profile_about', with: 'Im a cat!'
    click_button 'Create Profile'

    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Comment"
    click_on(class: 'comment-gemlike-btn')
    expect(has_css?('i.fa-gem', count: 1)).to eq true
  end

  scenario "a user can unlike a comment" do
    visit '/'
    fill_in 'profile_about', with: 'Im a cat!'
    click_button 'Create Profile'

    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Comment"
    click_on(class: 'comment-gemlike-btn')
    click_on(class: 'comment-gemunlike-btn')
    expect(has_css?('i.fa-gem', count: 0)).to eq true
  end
end
