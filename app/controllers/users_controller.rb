class UsersController < ApplicationController
  respond_to :json

  def index
    before = params[:before]
    after = params[:after]

    if before && after
      @users = User.where(birthdate: after..before)
    elsif before
      @users = User.where("birthdate < ?", before)
    elsif after
      @users = User.where("birthdate > ?", after)
    else
      @users = User.all
    end

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
