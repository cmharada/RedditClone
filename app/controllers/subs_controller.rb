class SubsController < ApplicationController
  before_action :ensure_user_is_mod, only: [:edit, :update, :destroy]
  
  def new
    @sub = Sub.new
    render :new
  end
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def index
    @subs = Sub.all
    render :index
  end
  
  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end
  
  private
  
  def ensure_user_is_mod
    unless Sub.find(params[:id]).moderator == current_user
      flash[:errors] = ["You are not the moderator of that sub"]
      redirect_to subs_url
    end
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
