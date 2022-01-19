

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    # @post = Post.create(post_params)
    @post = @user.posts.create(post_params)
    redirect_to posts_url
  end

  def index
    @posts = Post.all.order('created_at DESC')
  end

  private

  def post_params
    # unless Rails.env.test?
    #   path = post_params[:image].tempfile.path
    #   ImageProcessing::MiniMagick.source(path)
    #     .resize_to_limit(400, 400)
    #     .call(destination: path)
    # end
    params.require(:post).permit(:message,:image)
  end
end
