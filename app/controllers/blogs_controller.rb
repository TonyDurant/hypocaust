class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:index, :new, :show, :update, :edit, :destroy]
  before_filter :find_blog, only: [:show, :update, :destroy, :edit]
  before_filter :check_user, only: [:show, :update, :edit, :destroy]  

  def index
    @blogs = Blog.all
  end

  def show
    unless @blog
      render_404 and return 
    end
  end

  def new
    if current_user.try(:status) == 'admin'
      @blog = Blog.new
    else render_403
    end
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        attach_user
        format.html { redirect_to blog_path(@blog), notice: 'blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_path(@blog), notice: 'blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:name, :description, :user_id)
    end

    def find_blog
      @blog = Blog.where(id: params[:id]).first
      render_404 unless @blog
    end

    def check_user
      render_403 unless @blog.user == current_user || @current_user.status == 'admin'
    end

    def attach_user
      @blog.user_id = current_user.id
      @blog.save
    end

end
