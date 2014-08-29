class PostsController < ApplicationController
  before_action :ensure_author_is_current_user, only: [:edit, :update, :destroy]
  before_action :ensure_user_logged_in, only: [:new, :create]
  
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
    @post = Post.find(params[:id])
    @subs = Sub.all
    @current_sub = Sub.find(params[:sub_id])
    render :edit
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_post_url(@post.sub, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @sub = Sub.find(params[:sub_id])
    render :show
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to @post.sub
  end
  
  private
  
  def ensure_author_is_current_user
    unless Post.find(params[:id]).author == current_user
      flash[:errors] = ["You did not author this post"]
      redirect_to sub_url(Post.find(params[:id]).sub)
    end
  end
  
  def ensure_user_logged_in
    unless current_user
      flash[:errors] = ["You must log in to post"]
      redirect_to new_session_url
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
