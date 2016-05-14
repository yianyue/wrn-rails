class Api::UsersController < ApplicationController

  before_action :authenticate_user
  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.new(user_params)
    # json.(@user, :password, :password_confirmation, :name, :email, :goal) #is this necessary?
    render json: @user.errors, status: :bad_request unless @user.save
  end

  def show
    # TODO: use jbuilder
    render json: current_user
  end

  def update
    @user = current_user
    @user.attributes = user_params
    render json: @user.errors, status: :bad_request unless @user.save
  end

  protected

  def user_params
    params.require(:data).permit(:password, :password_confirmation, :name, :email, :goal, :time_zone)
  end

end
