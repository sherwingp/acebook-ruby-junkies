# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  include ActionView::RecordIdentifier

  def index
    @posts = Post.all.order('created_at DESC')
    # @user = User.find(current_user.id)
    # @profile = @user.profiles.first
  end

  def show
    @post = Post.find(params[:id]) if params[:id] != 'new'
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    @post = @user.posts.create(post_params)
    if @post.save
      flash[:notice] = "Messaged posted!"
      redirect_to posts_url
    else 
      flash[:alert] = "Something went wrong, please try again!"
      redirect_to posts_url
    end
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path if current_user.id != @post.user_id
  end

  def update
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id 
      if post_params[:image]
        Cloudinary::Uploader.destroy(@post.image.key) if @post.image.key
      end
        @post.update(post_params) 
    end
    if @post.save
      flash[:notice] = "Edit successful!"
      redirect_to posts_path(@post, anchor: dom_id(@post))
    else
      flash[:alert] = "Edit unsuccessful, please try again!"
      redirect_to posts_url
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id
      Cloudinary::Uploader.destroy(@post.image.key) if @post.image.key
      @post.comments.each do |comment|
        Cloudinary::Uploader.destroy(comment.image.key) if comment.image.key
      end
      @post.destroy
      flash[:notice] = "Message successfully deleted!"
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:message,:image)
  end
end
