class Tweet < TwitterModel
  attr_accessor \
    :id,
    :id_str,
    :created_at,
    :text,
    :truncated,
    :entities,
    :source,
    :in_reply_to_status_id,
    :in_reply_to_status_id_str,
    :in_reply_to_user_id,
    :in_reply_to_user_id_str,
    :in_reply_to_screen_name,
    :user,
    :geo,
    :coordinates,
    :place,
    :contributors,
    :is_quote_status,
    :retweet_count,
    :favorite_count,
    :favorited,
    :retweeted,
    :possibly_sensitive,
    :lang,
    :quoted_status_id,
    :quoted_status_id_str,
    :quoted_status,
    :retweeted_status,
    :extended_entities,
    :possibly_sensitive_appealable

  def attributes
    { "created_at" => nil,
      "id" => nil,
      "id_str" => nil,
      "text" => nil,
      "truncated" => nil,
      "entities" => nil,
      "source" => nil,
      "in_reply_to_status_id" => nil,
      "in_reply_to_status_id_str" => nil,
      "in_reply_to_user_id" => nil,
      "in_reply_to_user_id_str" => nil,
      "in_reply_to_screen_name" => nil,
      "user" => nil,
      "geo" => nil,
      "coordinates" => nil,
      "place" => nil,
      "contributors" => nil,
      "is_quote_status" => nil,
      "retweet_count" => nil,
      "favorite_count" => nil,
      "favorited" => nil,
      "retweeted" => nil,
      "possibly_sensitive" => nil,
      "lang" => nil,
      "quoted_status_id" => nil,
      "quoted_status_id_str" => nil,
      "quoted_status" => nil,
      "retweeted_status" => nil,
      "extended_entities" => nil,
      "possibly_sensitive_appealable" => nil }
  end

  def fetch_data
    api_connection.status(id)
  end

  def user
    @user_model ||= User.new(@user.to_hash)
  end

  def self.find(id, fetch: false)
    # TODO: Cache user info
    # TODO: Don't lookup until we want a field
    Tweet.new(id: id).tap do |t|
      t.load_remote_attributes
    end
  end
end