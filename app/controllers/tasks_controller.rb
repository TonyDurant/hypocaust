class TasksController < ApplicationController
  before_filter :user_logged_in, only: [:index]
  before_action :set_task, only: [:show, :edit, :update, :destroy, :done, :take]
  before_filter :authenticate_user!, only: [:new, :update, :edit, :destroy]
  before_filter :find_task, only: [:show, :update, :destroy, :edit]
  before_filter :check_user, only: [:update, :edit, :show, :done, :take]
  before_filter :owner, only: [:destroy]

  def index
    @tasks = Task.all.where(user_id: current_user.id)
  end

  def drafts
    if current_user.try(:status) == 'admin'
      @tasks_raw = Task.all
      @tasks_in_draft = @tasks_raw.where(draft: true).order('created_at DESC')
      @tasks = @tasks_raw.where(draft: true).order('created_at DESC')
    else render_403
    end
  end

  def about
    render("about")
  end

  def show
    unless @task
      render_404 and return
    end
    @comments = @task.comments.order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    if current_user.try(:status) == 'admin'
      @task = Task.new
    else render_403
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        attach_user
        format.html { redirect_to :back, notice: 'task was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        @comments = @task.comments.order('created_at DESC')
        format.html { redirect_to task_path(@task), notice: 'task was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js { render js: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def take
    @task = Task.find(params[:id])
    @task.state = "in progress"
    @task.user_id = current_user.id
    @task.start_time = Time.now
    respond_to do |format|
      if @task.save
        @task.create_activity action: 'take', recipient: @task.construction_site, owner: current_user
        format.html { redirect_to :back, notice: 'task was successfully taken.' }
        format.js
      else
        format.html { render :back }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def done
    @task = Task.find(params[:id])
    @task.state = "done"
    respond_to do |format|
      if @task.save
        @task.create_activity action: 'done', recipient: @task.construction_site, owner: current_user
        format.html { redirect_to :back, notice: 'task was successfully complete.' }
        format.js
      else
        format.html { render :back }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def all_done
    @construction_site = ConstructionSite.find(params[:construction_site_id])
    render_403 unless @construction_site.users.include?(current_user)
    @tasks = @construction_site.tasks.where(state: 'done').paginate(:page => params[:page], :per_page => 10).order('created_at DESC').order('color DESC')
  end

  private
    def add_comment(task)
      @task = task
      body = "Task state was changed to: " + @task.state
      c = Comment.new(user_id: current_user.id, body: body, commentable_type: "Task", commentable_id: @task.id)
      c.save
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :desc, :duration, :construction_site_id, :start_time, :state, :user_id, :sprint_id, :color, :end_time)
    end

    def find_task
      @task = Task.where(id: params[:id]).first
      render_404 unless @task
    end

    def check_user
      render_403 unless @task.construction_site.users.include?(current_user)
    end

    def owner
      render_403 unless @task.user == current_user
    end

    def attach_user
      if @task.user_id.nil?
        @task.user_id = current_user.id
        @task.save
      end
    end

    def user_logged_in
      unless user_signed_in?
        about
      end
    end
end
