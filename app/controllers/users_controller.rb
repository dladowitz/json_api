class UsersController < ApplicationController
  respond_to :json

  def index
    before = params[:before] || Date.today
    after = params[:after] || 100.years.ago
    @users = User.where(birthdate: after..before)

    render json: @users
  end

  def create
    user = User.new user_params
    if user.save
      render json: user, status: 201
    else
      render json: "Sorry, we couldn't create a user from those params", status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :birthdate)
  end
end
