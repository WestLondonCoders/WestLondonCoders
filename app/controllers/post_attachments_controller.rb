class PostAttachmentsController < ApplicationController
  before_action :set_post_attachment, only: [:show, :edit, :update, :destroy]

  def index
    @post_attachments = PostAttachment.all
  end

  def show
  end

  def new
    @post_attachment = PostAttachment.new
  end

  def edit
  end

  def create
    @post_attachment = PostAttachment.new(post_attachment_params)

    respond_to do |format|
      if @post_attachment.save
        format.html { redirect_to @post_attachment, notice: 'Post attachment was successfully created.' }
        format.json { render :show, status: :created, location: @post_attachment }
      else
        format.html { render :new }
        format.json { render json: @post_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post_attachment.update(post_attachment_params)
        format.html { redirect_to @post_attachment.post, notice: 'Post attachment was successfully updated.' }
      end
    end
  end

  def destroy
    @post_attachment.destroy
    respond_to do |format|
      format.html { redirect_to post_attachments_url, notice: 'Post attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post_attachment
    @post_attachment = PostAttachment.find(params[:id])
  end

  def post_attachment_params
    params.require(:post_attachment).permit(:post_id, :avatar)
  end
end
