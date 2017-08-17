require 'httparty'
require 'json'
require './lib/roadmap.rb'
require './lib/messages.rb'

class Kele
  include HTTParty
  include Roadmap
  include Messages
  attr_reader :auth_token
  attr_reader :user_data

  def initialize(email, password)
    response = self.class.post(base_url("sessions"),
    body: {
      "email": email,
      "password": password
    })
    raise 'Email or password was incorrect' if response.code == 404
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(base_url("users/me"), headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(base_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end

  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    response = self.class.post(base_url("checkpoint_submissions"),
    body: {
      "assignment_branch": assignment_branch,
      "assignment_commit_link": assignment_commit_link,
      "checkpoint_id": checkpoint_id,
      "comment": comment,
      "enrollment_id": enrollment_id
    },
    headers: { "authorization" => @auth_token })
  end

  private
  def base_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end
end
