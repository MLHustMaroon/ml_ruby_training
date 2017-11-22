class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create]

  def new
    @post = @current_user.posts.new
  end

  def create
    @post = @current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)
    unless @post.save
      flash.now[:warning] = 'error'
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    unless @post.destroy
      flash.now[:warning] = "error"
      redirect_to post_path @post
    end
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.sort_by {|cmt| cmt.rate}.reverse - @post.comments.where(id: nil)
  end

  def index
    @posts = current_user.posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
  private
  def correct_user
    @post = Post.find(params[:id])
    unless (logged_in? && @current_user == @post.user)
      flash.now[:danger] = 'no permission'
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      flash.now[:danger] = 'please login first'
      redirect_to login_path
    end
  end

end
