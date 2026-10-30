require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, as: :json, headers: sign_in_as(@user)
    assert_response :success
  end

  test "should create user and return a session token" do
    assert_difference("User.count") do
      post users_url, params: { user: { email_address: "new_user@email.com", password: "password" } }, as: :json
    end

    new_user = User.find_by(email_address: "new_user@email.com")
    token = response.parsed_body["token"] # creates new user along with new session and associated token

    assert_response :created
    assert new_user.sessions.exists?(token: token)
  end

  test "should show user" do
    get user_url(@user), as: :json, headers: sign_in_as(@user)
    assert_response :success
  end

  test "should update user" do
    update_user_params = { user: { email_address: @user.email_address, password: "new_password" } }
    patch user_url(@user), params: update_user_params, as: :json, headers: sign_in_as(@user)
    assert_response :success
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user), as: :json, headers: sign_in_as(@user)
    end

    assert_response :no_content
  end
end
