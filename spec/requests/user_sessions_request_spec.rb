require 'rails_helper'

describe "POST /users/auth/facebook" do
  before(:each) do
    valid_facebook_login_setup
  end

  it "should redirect to callback" do
    post user_facebook_omniauth_authorize_path
    expect(response).to redirect_to user_facebook_omniauth_callback_path
  end
end