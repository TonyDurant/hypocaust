class SprintsController < ApplicationController

  def index
    if params[:blog_id]
      @posts = Post.where(blog_id: params[:blog_id]).where(draft: false).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
      @posts_in_draft = Post.all.where(draft: true).order('created_at DESC')
    else
      @posts = Post.all.where(draft: false).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
      @posts_in_draft = Post.all.where(draft: true).order('created_at DESC')
    end
    #@search = Post.search do
    #  fulltext params[:search]
    #  order_by :created_at, :desc
    #  paginate :page => params[:page], :per_page => 20
    #end
    #@posts = @search.results
  end

  def drafts
    if current_user.try(:status) == 'admin'
      @posts_raw = Post.all
      @posts_in_draft = @posts_raw.where(draft: true).order('created_at DESC')
      @posts = @posts_raw.where(draft: true).order('created_at DESC')
    else render_403
    end
  end

  def about
    render("about")
  end

  def show
    unless @post
      render_404 and return 
    end
  end

  def new
    if current_user.try(:status) == 'admin'
      @sprint = Sprint.new
    else render_403
    end
  end

  def edit
  end

  def create
    @sprint = Sprint.new(sprint_params)

    respond_to do |format|
      if @sprint.save
        attach_user
        format.html { redirect_to :back, notice: 'sprint was successfully created.' }
        format.json { render :show, status: :created, location: @sprint }
      else
        format.html { render :new }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_path(@post), notice: 'post was successfully updated.' }
        format.json { render :back, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def take
    @sprint = Sprint.find(params[:id])
    @sprint.state = "in progress"    
    @sprint.save
    respond_to do |format|
      format.html { redirect_to :back, notice: 'task has successfully taken.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def sprint_params
      params.require(:sprint).permit(:name, :desc, :construction_site_id, :user_id)
    end

    def find_post
      @post = Post.where(id: params[:id]).first
      render_404 unless @post
    end

    def check_user
      render_403 unless @post.user == current_user || @current_user.status == 'admin'
    end

    def attach_user
      if @sprint.user_id.nil?
        @sprint.user_id = current_user.id
        @sprint.save
      end
    end

    def user_logged_in
      unless user_signed_in?
        about
      end
    end
end
