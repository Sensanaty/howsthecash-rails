class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: @user }, status: :ok
    else
      render json: { error: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :password, :email)
  end
end
