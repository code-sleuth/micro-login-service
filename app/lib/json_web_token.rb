require 'jwt'

class JsonWebToken
  @rsa_private = OpenSSL::PKey::RSA.generate 2048
  @rsa_public = @rsa_private.public_key

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    payload.reverse_merge!(meta)
    JWT.encode payload, @rsa_private, 'RS256'
  end

  def self.decode(token)
    JWT.decode token, @rsa_public, true, algorithm: 'RS256'
  end

  def self.valid_payload(payload)
    if expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud]
      return false
    else
      return true
    end
  end

  def self.meta
    {
      exp: 24.hours.from_now.to_i,
      iss: 'andela',
      aud: 'client',
    }
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end
end