class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session #, if: Proc.new { |c| c.request.format == 'application/json' }

  # {"email":"kafka@gmail.com","name":"Franz","goal":500,"token":"e628adf7-154a-4631-953a-05bb58c766cd"}

  def current_user
    # @current_user ||= User.find_by(email: request.headers['email'])
    @current_user = User.find_by(email: 'kafka@gmail.com')

  end

  def authenticate_user
    # @user = User.find_by(email: request.headers['email'])
    # if @user && @user.token == request.headers['token']
      true
    # else
    #   render json: {error: 'You are not authorized to access this page. Please login.'}, status: 401
    # end
  end

  helper_method :current_user, :authenticate_user

end
