class PostsController < ApplicationController
  def new
    @post = Post.new
    @subs = Sub.all
    @current_sub = Sub.find(params[:sub_id])
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to sub_url(params[:post][:sub_id])
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def show
    @post = Post.find(params[:id])
    @sub = Sub.find(params[:sub_id])
    render :show
  end
  
  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
