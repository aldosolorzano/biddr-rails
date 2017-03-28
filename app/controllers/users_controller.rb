class UsersController < ApplicationController
  before_action :authenticate_user!,only:[:index]

  def index
    @auctions = current_user.watch_auctions
  end

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name,
                                        :last_name,
                                        :email,
                                        :password,
                                        :password_confirmation)
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Sign up succesfully'
    else
      render :new
    end
  end

end
