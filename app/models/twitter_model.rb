class TwitterModel
  include ActiveModel::Model
  include ActiveModel::Serialization

  def fetch_data; raise NotImplementedError; end
  def load_embedded_associations; raise NotImplementedError; end
  def self.find; raise NotImplementedError; end

  # @raises Twitter::Error::NotFound, Twitter::Error::Forbidden, Twitter::Error::Unauthorized
  def load_remote_attributes
    assign_attributes remote_data.to_hash
  end

  def remote_data
    @remote_data ||= fetch_data
  end

  def api_connection
    @api_connection ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Settings.twitter_api.consumer_key
      config.consumer_secret     = Settings.twitter_api.consumer_secret
      config.access_token        = Settings.twitter_api.access_token
      config.access_token_secret = Settings.twitter_api.access_token_secret
    end
  end
end