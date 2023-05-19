class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @users = User.all    
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to user_path(@user), flash: { notice: "User was created successfully"}
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @old_email = @user.email
    if @user.update(user_params)
      UserMailer.with(user: @user, old_email: @old_email).changed_email.deliver_now if @old_email != @user.email
      redirect_to user_path(@user), flash: { notice: "Profile was updated successfully"}
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, flash: { notice: "User was deleted successfully"}
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
