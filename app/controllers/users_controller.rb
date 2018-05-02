class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: '登録が完了しました'
    else
      flash.now[:alert] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to topics_path, notice: '登録が完了しました'
    else
      flash.now[:alert] = "登録に失敗しました"
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to topics_path unless @user == current_user
  end
end
