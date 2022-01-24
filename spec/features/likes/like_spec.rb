# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    post = FactoryBot.create(:post)
  end

  scenario "a user can like a post" do
    visit '/posts'
    click_on 'Like'
    expect(has_css?('i.fa-thumbs-up', count: 1)).to eq true
  end

  scenario "multiple users can like a post" do
    visit '/posts'
    click_on 'Like'
    user2 = FactoryBot.create(:user)
    login_as(user2, :scope => :user)
    visit '/posts'
    click_on 'Like'

    expect(has_css?('i.fa-thumbs-up', count: 1)).to eq true
    page.has_css?('div.likes-count', text: '2')
  end

  scenario "a user can unlike a post" do
    visit '/posts'
    click_on 'Like'

    click_on 'Unlike'
    expect(has_css?('i.fa-thumbs-up', count: 0)).to eq true
  end

  scenario "a user can like a comment" do
    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Comment"
    click_on(class: 'comment-like-btn')
    expect(has_css?('i.fa-thumbs-up', count: 1)).to eq true
  end

  scenario "a user can unlike a comment" do
    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Comment"
    click_on(class: 'comment-like-btn')
    click_on(class: 'comment-unlike-btn')
    expect(has_css?('i.fa-thumbs-up', count: 0)).to eq true
  end
end
