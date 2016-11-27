# @raises Twitter::Error::NotFound, Twitter::Error::Forbidden, Twitter::Error::Unauthorized
class User < TwitterModel
  attr_accessor \
    :id,
    :id_str,
    :name,
    :screen_name,
    :location,
    :profile_location,
    :description,
    :url,
    :entities,
    :protected,
    :followers_count,
    :friends_count,
    :listed_count,
    :created_at,
    :favourites_count,
    :utc_offset,
    :time_zone,
    :geo_enabled,
    :verified,
    :statuses_count,
    :lang,
    :status,
    :contributors_enabled,
    :is_translator,
    :is_translation_enabled,
    :profile_banner_url,
    :profile_background_color,
    :profile_background_image_url,
    :profile_background_image_url_https,
    :profile_background_tile,
    :profile_image_url,
    :profile_image_url_https,
    :profile_link_color,
    :profile_sidebar_border_color,
    :profile_sidebar_fill_color,
    :profile_text_color,
    :profile_use_background_image,
    :has_extended_profile,
    :default_profile,
    :default_profile_image,
    :following,
    :follow_request_sent,
    :notifications,
    :translator_type,
    :suspended,
    :needs_phone_verification,
    :live_following,
    :muting,
    :blocking,
    :blocked_by

  def attributes
    { "id" => nil,
      "id_str" => nil,
      "name" => nil,
      "screen_name" => nil,
      "location" => nil,
      "profile_location" => nil,
      "description" => nil,
      "url" => nil,
      "entities" => nil,
      "protected" => nil,
      "followers_count" => nil,
      "friends_count" => nil,
      "listed_count" => nil,
      "created_at" => nil,
      "favourites_count" => nil,
      "utc_offset" => nil,
      "time_zone" => nil,
      "geo_enabled" => nil,
      "verified" => nil,
      "statuses_count" => nil,
      "lang" => nil,
      "status" => nil,
      "contributors_enabled" => nil,
      "is_translator" => nil,
      "is_translation_enabled" => nil,
      "profile_background_color" => nil,
      "profile_background_image_url" => nil,
      "profile_background_image_url_https" => nil,
      "profile_background_tile" => nil,
      "profile_image_url" => nil,
      "profile_image_url_https" => nil,
      "profile_link_color" => nil,
      "profile_sidebar_border_color" => nil,
      "profile_sidebar_fill_color" => nil,
      "profile_text_color" => nil,
      "profile_use_background_image" => nil,
      "has_extended_profile" => nil,
      "default_profile" => nil,
      "default_profile_image" => nil,
      "following" => nil,
      "follow_request_sent" => nil,
      "notifications" => nil,
      "translator_type" => nil,
      "suspended" => nil,
      "needs_phone_verification" => nil,
      "profile_banner_url" => nil,
      "live_following" => nil,
      "muting" => nil,
      "blocking" => nil,
      "blocked_by" => nil }
  end

  # @todo: Return an ActiveRecord::Relation here instead, also do voodoo to lazy query.
  # @raises Twitter::Error::NotFound, Twitter::Error::Forbidden, Twitter::Error::Unauthorized
  def tweets
    api_connection.user_timeline(id.to_i).map { |tweet| Tweet.new(tweet.to_hash) }
  end

  def friends
    api_connection.friends(id.to_i).map { |user| User.new(user.to_hash) }
  end

  def fetch_data
    api_connection.user(id.to_i)
  end

  # @todo Find a way to avoid this "fetch" keyword here
  def self.find(id, fetch: false)
    # TODO: Cache user info
    # TODO: Don't lookup until we want a field
    User.new(id: id).tap { |u| u.load_remote_attributes if fetch }
  end
end
