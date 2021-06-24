class SlackMessage < Message

    attr_accessor :attachments
    
    def initialize(attachments='')
        super
        @attachments = attachments
    end

    def send_later
        SlackDefectiveCarsJob.perform_later(TEST_SLACK_URL, self.message, self.attachments)
    end
end