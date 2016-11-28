class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  http_basic_authenticate_with({
    name: ENV['BASIC_AUTH_NAME'] || Settings.auth.name,
    password: ENV['BASIC_AUTH_PASSWORD'] || Settings.auth.password
  })

  def safely_twitter
    yield
  rescue Twitter::Error::BadRequest => err # 400
    Rails.logger.warn "Twitter API returned " + err.message
    head 400
  rescue Twitter::Error::Unauthorized => err # 401
    Rails.logger.warn "Twitter API returned " + err.message
    head 401
  rescue Twitter::Error::Forbidden => err # 403
    Rails.logger.warn "Twitter API returned " + err.message
    head 403
  rescue Twitter::Error::NotFound => err # 404
    Rails.logger.warn "Twitter API returned " + err.message
    head 404
  rescue Twitter::Error::NotAcceptable => err # 406
    Rails.logger.warn "Twitter API returned " + err.message
    head 406
  rescue Twitter::Error::RequestTimeout => err # 408
    Rails.logger.warn "Twitter API returned " + err.message
    head 408
  rescue Twitter::Error::EnhanceYourCalm => err # 420
    Rails.logger.warn "Twitter API returned " + err.message
    head 420
  rescue Twitter::Error::UnprocessableEntity => err # 422
    Rails.logger.warn "Twitter API returned " + err.message
    head 422
  rescue Twitter::Error::TooManyRequests => err # 429
    Rails.logger.warn "Twitter API returned " + err.message
    head 429
  rescue Twitter::Error::InternalServerError => err # 500
    Rails.logger.warn "Twitter API returned " + err.message
    head 500
  rescue Twitter::Error::BadGateway => err # 502
    Rails.logger.warn "Twitter API returned " + err.message
    head 502
  rescue Twitter::Error::ServiceUnavailable => err # 503
    Rails.logger.warn "Twitter API returned " + err.message
    head 503
  rescue Twitter::Error::GatewayTimeout => err # 504
    Rails.logger.warn "Twitter API returned " + err.message
    head 504
  rescue ArgumentError => err
    Rails.logger.warn "Invalid parameters given " + err.message
    head 422
  end

  protected

  def current_user
    @current_user ||= User.find_by_screen_name(params[:user_id])
  end
end
