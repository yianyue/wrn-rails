class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session #, if: Proc.new { |c| c.request.format == 'application/json' }

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  around_filter :user_time_zone, :if => :current_user

  def current_user
    @current_user ||= User.find_by(email: request.headers['email'])
  end

  def authenticate_user
    @user = User.find_by(email: request.headers['email'])
    if @user && @user.token == request.headers['token']
      true
    else
      p @user.token
      render json: {error: 'You are not authorized to access this page. Please login.'}, status: :unauthorized
    end
  end

  private

  def record_not_found
    render json: {error: 'Record does not exist.'}, status: :not_found
  end

  def user_time_zone(&block)
    # what happens if a user changes their time zone?
    Time.use_zone(current_user.time_zone, &block)
  end

  helper_method :current_user, :authenticate_user

end
