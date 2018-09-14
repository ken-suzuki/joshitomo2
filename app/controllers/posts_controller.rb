class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
  end
  
  def create
    @topic = Topic.find(params[:id])
    @post = @topic.posts.build(comment_params)
    @post.user = current_user
    
    if @post.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to :back
    else
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      redirect_to :back
    end
  end
  
  def destroy
    @post.destroy if @post.errors.empty?
    flash[:success] = 'コメントを削除しました。'
    redirect_to :back
  end
  
  def reply
    @reply = @topic.posts.build(parent: @post)
  end
  
  private

  def comment_params
    params.require(:post).permit(:comment, :photo, :parent_id)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end

end
