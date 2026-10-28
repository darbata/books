module SessionTestHelper
  def sign_in_as(user)
    new_session = user.sessions.create!
    { "Authorization" => "Bearer #{new_session.token}" }
  end
end

ActiveSupport.on_load(:action_dispatch_integration_test) do
  include SessionTestHelper
end
