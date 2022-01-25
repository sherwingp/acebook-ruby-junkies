class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    if params[:id] != "new"
      @post = Post.find(params[:id])
    end
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    @post = @user.posts.create(post_params)
    redirect_to posts_url
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path if current_user.id != @post.user_id
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params) if current_user.id == @post.user_id
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if current_user.id == @post.user_id
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:message,:image)
  end
end
