class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
    # If acoount is not created, render the signup form with error message.
      flash.now[:alert] = "Failed to create account: " + @user.errors.full_messages.join(", ") # Set error message
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
