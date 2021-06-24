require 'net/http'

class SlackDefectiveCarsJob < ApplicationJob
  queue_as :default

  def perform(url, message, attachments)
    # Sends Slack messages
    req = Net::HTTP.post(
      URI(url), 
      { 
          "text" => message,
          "attachments" => attachments,
      }.to_json, 
      "Content-Type" => "application/json",
    )
    puts "REQUEST RESPONSE -----: #{req.body}"
  end
end
