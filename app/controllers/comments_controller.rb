# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments or /comments.json
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    authorize @comments
  end

  # GET /comments/1 or /comments/1.json
  def show
    @post = Post.find(params[:post_id])
    @comments = @post.comments.find(params[:id])
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
    authorize @comment
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment
  end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)

    @comment.user_id = current_user.id
    authorize @comment

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to post_path(params[:post_id]), notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to post_path(params[:post_id]), alert: "Comment was not created. #{@comment.errors.full_messages}" }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    authorize @comment
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(params[:post_id]), notice: 'Comment was successfully updated.' }
      else
        format.html { redirect_to post_path(params[:post_id]), alert: "Comment was not created. #{@comment.errors.full_messages}" }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    authorize @comment
    respond_to do |format|
     @comment.destroy!
     if @comment.destroyed?
      format.html { redirect_to post_path(params[:post_id]), notice: 'Comment was successfully destroyed.' }
     else
      format.html { redirect_to post_path(params[:post_id]), alert: "Comment was not destroyed. #{@comment.errors.full_messages}" }
     end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content)
  end
end
