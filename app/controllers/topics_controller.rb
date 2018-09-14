class TopicsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  
  def index
    if logged_in?
      @user = current_user
      @topic = current_user.topics.build  # form_for 用
      @topics = Topic.all.order('created_at DESC').page(params[:page])
      
    if params[:title].present? 
      @topics = @topics.get_by_title params[:title]
    end
    
    @new_topics = Topic.all.order('created_at DESC').limit(5)
    @ranking_counts = Post.ranking
    @ranking_topics = Topic.find(@ranking_counts.keys)
    @rankingtop_counts = Post.rankingtop
    @rankingtop_topics = Topic.find(@rankingtop_counts.keys)

    end
  end

  def show
    @topic = Topic.find(params[:id])
    @new_topics = Topic.all.order('created_at DESC').limit(5)
    @post = @topic.posts.build
    @posts = @topic.posts.all.order('created_at DESC').page(params[:page])

    @ranking_counts = Post.ranking
    @ranking_topics = Topic.find(@ranking_counts.keys)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)

    if @topic.save
      flash[:success] = 'トピックが投稿されました'
      redirect_to topics_url
    else
      flash.now[:danger] = 'トピックが投稿されませんでした'
      render :new
    end
    
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      flash[:success] = 'トピックが更新されました'
      redirect_to @topic
    else
      flash.now[:danger] = 'トピックは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    flash[:success] = 'トピックを削除しました。'
    redirect_to topics_url
  end
  
  private

  def topic_params
    params.require(:topic).permit(:title, :content, :picture)
  end
  
  def correct_user
    @topic = current_user.topics.find_by(id: params[:id])
    unless @topic
      redirect_to root_url
    end
  end
end
