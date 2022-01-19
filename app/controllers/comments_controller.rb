class CommentsController < ApplicationController
  # def create
  #   @post = Post.find(params[:post_id])
  #   @comment = @post.comments.create(comment_params)
  #   @comment.user_id = current_user.id 
  #   if @comment.save
  #     redirect_to @post
  #   else
  #     # flash.now[:danger] = "error"
  #     puts "error"
  #   end
  # end

  # private
  #   def comment_params
  #     params = params.require(:comment).permit(:body)
  #   end

  before_action :set_user
  before_action :set_post

  def create
    @comment = @post.comments.create(comment_params)

    if @comment.save
      redirect_to @post
    else
      flash.now[:danger] = "error"
    end
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

   def set_user
      @user = User.find(current_user.id)
   end

   def comment_params
     params[:comment].permit(:body, :user_id)
   end
end
