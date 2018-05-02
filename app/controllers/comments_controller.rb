class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def new
    @comment = Comment.new
    @topic_id = params[:topic_id]
  end

  def create
    @comment = Comment.new(content: params[:comment][:content], topic_id: params[:topic_id], user_id: params[:user_id])
    if @comment.save
      redirect_to topics_path, notice: 'コメントを投稿しました'
    else
      flash.now[:alert] = 'コメントを入力してください'
      render :new
    end
  end

  def index
    @topic = Topic.find_by(id: params[:topic_id])
    @comments = Comment.where(topic_id: params[:topic_id])
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to topics_path, notice: "コメントを削除しました"
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to topics_url unless @user == current_user
  end
end
