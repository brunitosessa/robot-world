require 'net/http'

class SlackMessage < Message

    attr_accessor :attachments
    
    def initialize(attachments='')
        super
        @attachments = attachments
    end

    def send
        # Sends Slack messages
        req = Net::HTTP.post(
        URI(self.url), 
        { 
            "text" => self.message,
            "attachments" => self.attachments,
        }.to_json, 
        "Content-Type" => "application/json",
      )
      req.body
    end
end