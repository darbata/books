require "test_helper"

class AuthenticationFlowsTest < ActionDispatch::IntegrationTest
  setup { @user = users(:one) }
  # test "the truth" do
  #   assert true
  # end
  #
  # books_controller#index with valid token returns array of books
  # books_controller#index with invalid token returns 401 (from unauthenticated access)
  # books_controller#index with no token returns 401 (from unauthenticated access)
  # destroyed tokens no longer grant access to books_controller#index
end
