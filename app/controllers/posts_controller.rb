class PostsController < ApplicationController
  before_filter :user_logged_in, only: [:index, :favorites]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :update, :edit, :destroy, :add_to_fav]
  before_filter :find_post, only: [:show, :update, :destroy, :edit, :add_to_fav]
  before_filter :check_user, only: [:update, :edit, :destroy]

  def index
    if params[:blog_id]
      @posts = Post.where(blog_id: params[:blog_id]).where(draft: false).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
      @posts_in_draft = Post.all.where(draft: true).order('created_at DESC')
    else
      @posts = Post.where(draft: false).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
      @posts_in_draft = Post.all.where(draft: true).order('created_at DESC')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
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
      @post = Post.new
    else render_403
    end
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        attach_user
        name_to_translit
        format.html { redirect_to post_path(@post), notice: 'post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        name_to_translit
        format.html { redirect_to post_path(@post), notice: 'post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
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

  def add_to_fav
    @favorite = Favorite.new(user_id: current_user.id, favorable_id: @post.id, favorable_type: "Post")
    @favorite.save
    redirect_to :back
  end

  def favorites
    a = []
    current_user.favorites.uniq!.each do |f|
      a << f.favorable.id
    end
    @posts = Post.where(id: a).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    render("favorites")
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :link, :body, :user_id, :blog_id, :image_url, :draft, :image_url, :short_desc)
    end

    def find_post
      @post = Post.where(id: params[:id]).first
      render_404 unless @post
    end

    def check_user
      render_403 unless @post.user == current_user || @current_user.status == 'admin'
    end

    def attach_user
      if @post.user_id.nil?
        @post.user_id = current_user.id
        @post.save
      end
    end

    def name_to_translit
      @post.link = Translit.convert(@post.title, :english)
      @post.save
    end

    def user_logged_in
      unless user_signed_in?
        about
      end
    end
end
