class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      # @user.generate_token
      render json: @user.as_json(only: [:name, :email, :goal, :token]), status: :ok
    else
      # TODO: more detail error
      render json: {error: 'invalid login'}, status: :unauthorized
    end
  end

end
