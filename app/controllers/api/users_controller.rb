class Api::UsersController < ApplicationController

  before_action :authenticate_user
  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.new(user_params)    
    if @user.save
      render json:  @user.as_json(only: [:name, :email, :goal, :token]), status: 200
    else
      render json: user_params, status: 422
    end
  end

  def show
    # TODO: use jbuilder
    render json: current_user
  end

  def update
    if current_user.update_attributes(user_params)
      render json: current_user.as_json(only: [:name, :email, :goal, :token]), status: 200
    else
      render json: @user.errors
    end
  end

  protected
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation, :name, :email, :goal)
  end

end
