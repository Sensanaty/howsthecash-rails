# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_request, except: %i[create login]

  def index
    render json: { user: current_user }, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { message: 'User Successfuly Created', token: token, user: @user }, status: :ok
    else
      render json: { error: @user.errors }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(username: user_params[:username])

    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token, user: @user }
    else
      render json: { error: 'Invalid username or password, please try again' }, status: :unauthorized
    end
  end

  def destroy
    current_user.destroy
  end

  private

  def user_params
    params.permit(:username, :password, :email)
  end
end
