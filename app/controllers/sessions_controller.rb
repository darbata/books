class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  rate_limit to: 10, within: 3.minutes, only: :create

  wrap_parameters false

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      new_session = start_new_session_for user
      render json: { token: new_session.token }, status: :created
    else
      head :unauthorized
    end
  end

  def destroy
    terminate_session
    head :no_content
  end
end
