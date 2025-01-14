require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe "FriendRequests", type: :request do

  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    sign_in @user1
  end

  describe "GET /" do
    it "opens the friend request page" do
      get friend_requests_url 
      expect(response).to have_http_status(302)
    end
  end

  describe "POST /" do
    it "creates a new friend request" do
      post friend_requests_url, :params => {:friend_id => @user2.id}
      expect(response).to have_http_status(302)
    end
  end

  describe "PATCH /" do
    it "accepts a friend request" do
      post friend_requests_url, :params => {:friend_id => @user2.id}
      sign_out @user1
      sign_in @user2
      @friend_request_id = @user1.friend_requests.first.id
      patch "/friend_requests/#{@friend_request_id}"
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE /" do
    it "can delete a friend request" do
      post friend_requests_url, :params => {:friend_id => @user2.id}
      @friend_request_id = @user1.friend_requests.first.id
      delete "/friend_requests/#{@friend_request_id}"
      expect(response).to have_http_status(302)
    end
  end
end
