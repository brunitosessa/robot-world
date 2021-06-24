class Message
    
    attr_accessor :message, :url

    def initialize(message='', url='')
        @message = message
        @url = url
    end

    def send_later
    end
end