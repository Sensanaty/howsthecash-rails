# frozen_string_literal: true

class ApplicationController < ActionController::API
  require 'json_web_token'
  attr_reader :current_user

  def authenticate_request
    nil unless payload

    @current_user = User.find_by(id: payload[0]['user_id'])
    invalid_authentication unless @current_user
  end

  def invalid_authentication
    render json: { error: 'Invalid Request, please try again' }, status: :unauthorized
  end

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  end
end
