class PostsController < ApplicationController
  before_action :ensure_author_is_current_user, only: [:edit, :update, :destroy]
  before_action :ensure_user_logged_in, only: [:new, :create]
  
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    @subs = Sub.all
    @post.sub_ids = params[:post][:sub_ids]
    @post.author = current_user
    if @post.save
      redirect_to subs_url
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.transaction do
      @post.sub_ids = params[:post][:sub_ids]
      @post.update(post_params)
    end      
      redirect_to subs_url
    else
    flash.now[:errors] = @post.errors.full_messages
    render :edit
  end
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    render :show
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end
  
  private
  
  def ensure_author_is_current_user
    unless Post.find(params[:id]).author == current_user
      flash[:errors] = ["You did not author this post"]
      redirect_to subs_url
    end
  end
  
  def ensure_user_logged_in
    unless current_user
      flash[:errors] = ["You must log in to post"]
      redirect_to new_session_url
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
