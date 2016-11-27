class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: Settings.auth.name, password: Settings.auth.password

  def safely_twitter
    yield
  rescue Twitter::Error::BadRequest # 400
    head 400
  rescue Twitter::Error::Unauthorized # 401
    head 401
  rescue Twitter::Error::Forbidden # 403
    head 403
  rescue Twitter::Error::NotFound # 404
    head 404
  rescue Twitter::Error::NotAcceptable # 406
    head 406
  rescue Twitter::Error::RequestTimeout # 408
    head 408
  rescue Twitter::Error::EnhanceYourCalm # 420
    head 420
  rescue Twitter::Error::UnprocessableEntity # 422
    head 422
  rescue Twitter::Error::TooManyRequests # 429
    head 429
  rescue Twitter::Error::InternalServerError # 500
    head 500
  rescue Twitter::Error::BadGateway # 502
    head 502
  rescue Twitter::Error::ServiceUnavailable # 503
    head 503
  rescue Twitter::Error::GatewayTimeout # 504
    head 504
  end

  protected

  def current_user
    @current_user ||= User.find(params[:user_id])
  end
end
