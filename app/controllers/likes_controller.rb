# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]
  include ActionView::RecordIdentifier

  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user_id: current_user.id) unless liked?
    redirect_to posts_path(@post, anchor: dom_id(@post))
  end

  def destroy
    if liked?
      @like.destroy
    else
      flash[:notice] = 'Cannot unlike'
    end
    redirect_to posts_path(@post, anchor: dom_id(@post))
  end

  private

  def liked?
    Like.exists?(user_id: current_user.id, post_id: params[:post_id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = @post.likes.find(params[:id])
  end
end
