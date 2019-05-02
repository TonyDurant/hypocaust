class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :archive, :make_task, :reply]
  before_filter :authenticate_user!, only: [:new, :create, :update, :edit, :archive]
  before_filter :find_comment, only: [:show, :update, :archive, :edit]
  before_filter :check_user, only: [:update, :edit, :archive, :show]

  def index
  end

  def show
    unless @comment
      render_404 and return
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        attach_user
        @construction_site = @comment.construction_site
        @comment.create_activity action: 'create', recipient: @comment.construction_site, owner: current_user, parameters: {commentable_type: @comment.commentable_type}
        create_link_thumbnail(@comment)
        @activities = @comment.activities
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def reply
    respond_to do |format|
      format.js
    end
  end

  def create_link_thumbnail(comment)
    @comment = comment
    require "uri"
    links = URI.extract(@comment.body, /http(s)?|mailto/)
    unless links.empty?
      links.each do |l|
        object = LinkThumbnailer.generate(l)
        unless object.title == '' || object.favicon == '' || object.description == ''
          unless object.images.empty?
            @link_thumbnail = LinkThumbnail.new(url: l, name: object.title, favicon: object.favicon, desc: object.description, image: object.images.first.src.to_s, comment_id: @comment.id)
            @link_thumbnail.save
          else
            @link_thumbnail = LinkThumbnail.new(url: l, name: object.title, favicon: object.favicon, desc: object.description, comment_id: @comment.id)
            @link_thumbnail.save
          end
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to :back, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def archive
    @comment.status == "archive"
    redirect_to :back
  end

  def make_task
    if @comment.commentable_type == "ConstructionSite"
      @task = Task.create(name: @comment.body.first(33), desc: @comment.body, construction_site_id: @comment.commentable_id, user_id: current_user.id, duration: 3, taskable_id: @comment.id, taskable_type: "Comment", state: "todo", end_time: Time.now)
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Task was successfully created out of comment.' }
      format.js
    end
  end

  private
    def find_comment
      @comment = Comment.where(id: params[:id]).first
      render_404 unless @comment
    end

    def set_comment
      @comment = Comment.find(params[:id])
      render_404 unless @comment
    end

    def comment_params
      params.require(:comment).permit(:body, :user_id, :file, :status, :commentable_id, :commentable_type)
    end

    def check_user
      render_403 unless @comment.construction_site.users.include?(current_user)
    end

    def attach_user
      @comment.user_id = current_user.id
      @comment.save
    end
end
