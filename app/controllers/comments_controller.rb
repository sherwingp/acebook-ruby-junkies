class CommentsController < ApplicationController

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
     params[:comment].permit(:body, :image, :user_id)
   end
end
