class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    # TODO: only admins can do this
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    return head :unauthorized unless @user == Current.user
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      new_session = start_new_session_for @user
      render json: { users: @user, token: new_session.token }, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /users/1
  def update
    return head :unauthorized unless @user == Current.user

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_content
    end
  end

  # DELETE /users/1
  def destroy
    return head :unauthorized unless @user == Current.user
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :email_address, :password ])
    end
end
