class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :followings, :followers]
  
  def index
    @users = User.all.page(params[:page])
    
    if params[:name].present? 
    @users = @users.get_by_name params[:name]
    end
    if params[:age].present?
    @users = @users.get_by_age params[:age]
    end
    if params[:live].present?
    @users = @users.get_by_live params[:live]
    end
    if params[:hobby].present?
    @users = @users.get_by_hobby params[:hobby]
    end
  end
  
  def show
    @user = User.find(params[:id])
    @topics = @user.topics.order('created_at DESC').page(params[:page])
    @followings = @user.followings.page(params[:page])
    @followers = @user.followers.page(params[:page])
    @favoritings = @user.favoritings.page(params[:page])
    @entries = @user.entries.page(params[:page])
    @ranking_counts = Post.ranking
    
    counts(@user)
    
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
          end
        end
      end
      if @isRoom
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @roomId = cu.room_id
            end
          end
        end
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favoritings
    @user = User.find(params[:id])
    @favoritings = @user.favoritings.page(params[:page])
  end
  
  def entries
    @user = User.find(params[:id])
    @entries = @user.entries.page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :live, :hobby, :image, :pr)
  end
  
end