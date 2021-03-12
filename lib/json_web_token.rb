class JsonWebToken
  def self.encode(payload)
    payload.reverse_merge!({ exp: 1.day.from_now.to_i })
    JWT.encode(payload, ENV['AUTH_SECRET_KEY'])
  end

  def self.decode(token)
    JWT.decode(token, ENV['AUTH_SECRET_KEY'])
  end
end