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
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /" do
    it "creates a new friend request" do
      post friend_requests_url, :params => {:friend_id => @user2.id}
      expect(response).to have_http_status(201)
    end
  end

  

  describe "DELETE /" do
    it "can delete a friend request" do
      post friend_requests_url, :params => {:friend_id => @user2.id}
      @friend_request_id = @user1.friend_requests.first.id
      delete "/friend_requests/#{@friend_request_id}"
      expect(response).to have_http_status(204)
    end
  end
end
