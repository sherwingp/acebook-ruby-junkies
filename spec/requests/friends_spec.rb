require 'rails_helper'

RSpec.describe "Friends", type: :request do

  before(:each) do
    @friend_request = FactoryBot.create(:friend_request)
    @user = User.find(@friend_request.user_id)
    sign_in @user
  end

  describe "GET /index" do
    it "returns http success" do
      get "/friends/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "get /destroy" do
    it "returns http success" do
      @friend_request.accept
      friend_id = @friend_request.friend_id
      post friends_destroy_url, :params => {:id => friend_id}
      expect(response).to have_http_status(302)
    end
  end
end
