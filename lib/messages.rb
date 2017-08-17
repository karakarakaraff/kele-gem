module Messages
  include HTTParty

  def get_messages(page = nil)
    if page == nil
      response = self.class.get(base_url("message_threads"), headers: { "authorization" => @auth_token })
    else
      response = self.class.get(base_url("message_threads?page=#{page}"), headers: { "authorization" => @auth_token })
    end
    @messages = JSON.parse(response.body)
  end

  def create_message(sender_email, recipient_id, message_thread, subject, body)
    response = self.class.post(base_url("messages"),
    body: {
      "sender": sender_email,
      "recipient_id": recipient_id,
      "token": message_thread,
      "subject": subject,
      "stripped-text": body
    },
    headers: { "authorization" => @auth_token })
  end
end
