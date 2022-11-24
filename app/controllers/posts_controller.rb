class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.includes(:user).all
  end

  def new
    @post = Post.new
    sprintf "%04d", rand(2 - 9999), unique: true
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post =Post.find(params[:id])
    url_extension = @post.id.to_s(36)
    @short_url = "http://localhost:3000/#{url_extension}"
  end

  def send_to_url
    id = params[:short_url].to_i(36)
    post = Post.find(id)
    redirect_to post.original_url
  end

    private

    def post_params
      params.require(:post).permit(:original_url)
    end
end
