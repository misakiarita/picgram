class PostsController < ApplicationController
before_action :set_feed, only: %i[ show edit update destroy]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
    end

  def create
    @post = Post.new(post_params)
    if params[:back]
        render :new
    else 
        if @post.save
            redirect_to new_post_path
        else
            render :new
        end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    redirect_to posts_path
    end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
        redirect_to post_path, notice: "Your post edited!"
    else
        render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id]) 
    @post.destroy
    redirect_to posts_path, notice:"Your post deleted!"
  end

  def confirm
    @post = Post.new(post_params)
    render :new if @post.invalid?
  end

  private

  def set_feed
    @post = Post.find(params[:id])
    end

  def post_params
    params.require(:post).permit(:image, :image_cache, :content)
  end
end
