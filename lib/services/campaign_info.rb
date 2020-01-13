module CampaignInfo
  # This class talks with External Campaign service which gives us campaign details
  class << self
    def initialize
      @logger = Rails.logger
      # @token = { "token"=>Rails.application.secrets[:services]['campaign_ad']['token']}
    end

    def fetch_data(params)
      res = self.class.get('/', query: params)
      if res.code.eql?(200)
        res.parsed_response
      else
        @logger.debug("Unable to reach CampaignAd service for #{params}")
        return nil
      end
      rescue Timeout::Error, Errno::ECONNREFUSED, Net::ReadTimeout, Net::OpenTimeout, SocketError, OpenSSL::SSL::SSLError
        @logger.debug("CampaignAd service timed outfor #{params}")
        return nil
      rescue StandardError
        return nil
    end
  end
end
