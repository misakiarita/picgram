class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]  
  
  def index
    @posts = Post.all
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  def create
    @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    if params[:back]
        render :new
    else 
        if @post.save
          PostMailer.post_mailer(@post.user.email).deliver
          redirect_to new_post_path
        else
            render :new
        end
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      render :edit
    else
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end
  
  def update
    if @post.update(post_params)
        redirect_to posts_path, notice: "Your post was edited!"
    else
        render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id]) 
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to posts_path, notice:"Your post was deleted!"
    end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :image_cache, :content)
  end

end
