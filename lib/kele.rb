require 'httparty'

class Kele
  include HTTParty
  attr_reader :auth_token

  def initialize(email, password)
    response = self.class.post(base_url("sessions"), body: { email: email, password: password })
    raise 'Email or password was incorrect' if response.code == 404
    @auth_token = response["auth_token"]
  end

  private
  def base_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end
end
