class CommentsController < ApplicationController
  before_action :require_user, only: [:create, :vote]
  def create
    @post= Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comments = Comment.all
    @comment.creator = @current_user
    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
      
    else
      render "posts/show"
    end
  end

  def vote 
    @comment = Comment.find(params[:id])
     vote = Vote.new(vote: params[:vote], voteable: @comment, creator: current_user)
     if vote.save
     flash[:notice] = "You've voted that successfully."
     else
      flash[:error] = "You only voted once."
     end
     redirect_to :back
  end

end 

#rediect -> URLs
#render -> template files 