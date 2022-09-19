# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments or /comments.json
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
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
  end

  # GET /comments/1/edit
  def edit
    content_not_found if current_user.id != @comment.user_id

    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)

    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save

        format.turbo_stream
        format.html { redirect_to post_path(params[:post_id]), notice: 'Comment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(params[:post_id]), notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    respond_to do |format|
      begin
        @comment.destroy!
        format.html { redirect_to post_path(params[:post_id]), notice: 'Comment was successfully destroyed.' }
      rescue
        format.html { redirect_to post_path(params[:post_id]), alert: 'Comment was not destroyed.' }
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
