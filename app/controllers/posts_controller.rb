class PostsController < ApplicationController
  before_action :set_post_and_category, only: [:show, :edit, :update, :vote]
  before_action :set_categoies, only: [:index, :show, :new, :edit, :create]
  before_action :require_user, except: [:show, :index]
  #1. set up instance variable for action
  #2. redirect based on some conditions

  def index
    @posts = Post.all.sort_by{|post| post.total_votes}.reverse
    render "posts/index"
  end

  def show
     @comment = Comment.new
     @comments = Comment.all.select{|comment| comment.post_id == params[:id].to_i}.sort_by{|comment| comment.votes.size}.reverse
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = @current_user
    if @post.save
      flash[:notice] = "Your post was created successfully"
      redirect_to posts_path
    else #validation error occurs
      render :new #because it fails to create, return to backpage
      # the reason of render rather redirect is we need to access the @post.save
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "The post was updated."
      redirect_to posts_path(@post)
    else
      render :edit  
    end
  end

  def vote
    vote = Vote.new(vote: params[:vote], creator: current_user, voteable: @post)
    if vote.save
      flash[:notice] = "You've voted that successfully."
    else
      flash[:error] = "You only are allowed to vote on a post once."
    end
    redirect_to :back
  end

  private



  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post_and_category
    @post = Post.find(params[:id])
    @categories = Category.all
  end

  def set_categoies
    @categories = Category.all
  end
end
