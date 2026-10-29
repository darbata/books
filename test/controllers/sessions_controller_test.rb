require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup { @user = users(:one) }

  test "create with valid credentials" do
    assert_difference -> { @user.sessions.count }, 1 do
      post session_path, params: { email_address: @user.email_address, password: "password" }, as: :json
    end

    assert_response :created
    token = response.parsed_body["token"]
    assert @user.sessions.exists?(token: token)
  end

  test "create with invalid credentials" do
    assert_no_difference -> { @user.sessions.count } do
      post session_path, params: { email_address: @user.email_address, password: "wrong" }, as: :json
    end
    assert_response :unauthorized
  end

  test "destroy" do
    headers = sign_in_as(@user)

    assert_difference -> { @user.sessions.count }, -1 do
      delete session_path, headers: headers, as: :json
    end

    assert_response :no_content
  end

  test "destroy with no token" do
    assert_difference -> { @user.sessions.count }, 0 do
      delete session_path, as: :json
    end
    assert_response :unauthorized
  end

  test "destroy with invalid token" do
    headers = { "Authorization" => "Bearer invalid" }
    assert_difference -> { @user.sessions.count }, 0 do
      delete session_path, headers: headers, as: :json
    end
    assert_response :unauthorized
  end
end
