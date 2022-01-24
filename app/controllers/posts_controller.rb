

class PostsController < ApplicationController
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
    # @post = Post.create(post_params)
    @post = @user.posts.create(post_params)
    redirect_to posts_url
  end

  def edit
    @post = Post.find(params[:id])
  end

  # edit_post_path	GET	/posts/:id/edit(.:format)	posts#edit
  # PUT	/posts/:id(.:format) posts#update

 

#   def show
#     @post = Post.find(params[:id])
#   end


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
