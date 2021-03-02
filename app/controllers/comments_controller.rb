class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :update ]
  before_action :find_article!
  before_action :is_current?, only: [ :update, :destroy ]

  def index
    @comments = @article.comments.order(created_at: :desc)

    render json: @comments
  end

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created, location: @article
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])

    if @comment.user_id == @current_user_id
      @comment.destroy
      render json: {}
    else
      render json: { errors: { comment: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def find_article!
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def is_current?
    @comment = @article.comments.find(params[:id])
    unless current_user == @comments.user
      render json: @comment.errors, status: :unauthorized
    end
  end
end
