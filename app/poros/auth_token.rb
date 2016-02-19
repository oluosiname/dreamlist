require "jwt"
class AuthToken
  def self.encode(payload, exp=24.hours.from_now)
    payload = payload.dup
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    # DecodedAuthToken.new(payload)
  rescue
    nil
  end
end
