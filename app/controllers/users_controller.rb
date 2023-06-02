class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy enroll_event discard_enrolled_event]
  before_action :find_event, only: %i[enroll_event discard_enrolled_event]

  def index
    @users = User.all
  end

  def show
    @events = Event.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
  
  def enroll_event
    @user.events << @event
    redirect_to user_path(@user)
  end
  
  def discard_enrolled_event
    @user.events.destroy(@event)
    redirect_to user_path(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
