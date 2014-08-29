class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:comment][:post_id])
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(params[:comment][:post_id])
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end
  
  def show
    @comment = Comment.find(params[:id])
    @new_comment = Comment.new
    render :show
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
