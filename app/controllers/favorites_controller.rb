class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    topic = Topic.find(params[:topic_id])
    current_user.like(topic)
    flash[:success] = 'お気に入り登録しました。'
    redirect_to topic
  end

  def destroy
    topic = Topic.find(params[:topic_id])
    current_user.unlike(topic)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_to topic
  end
end
