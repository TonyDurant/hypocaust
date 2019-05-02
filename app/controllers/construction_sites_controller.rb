class ConstructionSitesController < ApplicationController
  before_action :set_construction_site, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :update, :edit, :destroy, :show, :projects]
  before_filter :find_construction_site, only: [:show, :update, :destroy, :edit, :kanban, :metrics, :comments, :data, :add_task, :add_participants, :kick_user, :task_list, :attachments, :lead_time, :project_data, :add_lead_time, :completed_tasks]
  before_filter :check_user, only: [:show, :update, :edit, :destroy, :kanban, :metrics, :comments, :data, :add_task, :task_list, :attachments, :lead_time, :project_data, :add_participants, :add_lead_time, :completed_tasks]
  before_filter :check_hierarchy, only: [:edit, :destroy]
  require 'will_paginate/array'

  def kanban
    @sprints = @construction_site.sprints
    render("kanban")
  end

  def metrics
    render("metrics")
  end

  def comments
    @comments = @construction_site.comments.order('created_at DESC')
    render("construction_sites/comments")
  end

  def data
    @attachments = @construction_site.attachments
    render("data")
  end

  def add_task
    respond_to do |format|
      format.html
      format.js
    end
  end

  def add_lead_time
    respond_to do |format|
      format.html
      format.js
    end
  end

  def task_list
    @tasks = @construction_site.tasks.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def completed_tasks
    @tasks = @construction_site.tasks.where(state: "done")
    respond_to do |format|
      format.html
      format.js
    end
  end

  def attachments
    @attachments = @construction_site.attachments
    respond_to do |format|
      format.html
      format.js
    end
  end

  def lead_time
    @lead_time_data = []
    @construction_site.lead_times.order('title DESC').each do |lead_time|
      @lead_time_data << [lead_time.construction_site.name + ": " + lead_time.title, lead_time.start_date, lead_time.end_date]
    end
    @lead_times = @construction_site.lead_times.order('title DESC')
  end

  def index
    if user_signed_in?
      @construction_sites_all = current_user.construction_sites
      @construction_sites = @construction_sites_all.where(archive: false).order('name ASC')
      if params[:query].present?
        @searchables = current_user.construction_sites.text_search(params[:query])
      end

      #@construction_sites = current_user.construction_sites.text_search(params[:query]).order('name ASC')
      @all_activities = PublicActivity::Activity.all
      set_1 = @all_activities.where(recipient_id: @construction_sites_all.ids, recipient_type: "ConstructionSite")
      set_2 = @all_activities.where(recipient_id: user_task_ids, recipient_type: "Task")
      @activities = PublicActivity::Activity.where(id: set_1.ids + set_2.ids).order('created_at DESC')
      @activities = @activities.paginate(:page => params[:page], :per_page => 10)
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to action: 'about'
    end
  end

  def user_task_ids
    cs = current_user.construction_sites
    all_tasks = []
    cs.each do |cs|
      all_tasks = all_tasks + cs.task_ids
    end
    all_tasks
  end

  def lead_time_data(construction_sites)
    lead_time_ids = []
    construction_sites.each do |cs|
      cs.lead_times.each do |lt|
        lead_time_ids << lt.id
      end
    end
    lead_times = LeadTime.find(lead_time_ids)
    ary = []
    lead_times.each do |lead_time|
      ary << [lead_time.construction_site.name + ": " + lead_time.title, lead_time.start_date, lead_time.end_date]
    end
    if ary.empty?
      nil
    else
      ary
    end
  end

  def archived_projects
    @construction_sites = current_user.construction_sites.where(archive: true).paginate(:page => params[:page], :per_page => 10).order('created_at DESC') if user_signed_in?
    respond_to do |format|
      format.html
      format.js
    end
  end

  def lead_time_chart
    @construction_sites = current_user.construction_sites.where(archive: false).order('created_at DESC') if user_signed_in?
    @lead_time_data = lead_time_data(@construction_sites)
  end

  def my_tasks
    @construction_sites = current_user.construction_sites.where(archive: false).order('created_at DESC') if user_signed_in?
    @tasks = Task.where(construction_site_id: current_user.construction_site_ids, user_id: current_user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def project_data
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /construction_sites/1
  # GET /construction_sites/1.json
  def show
    unless @construction_site
      render_404 and return
    end
    @sprints = @construction_site.sprints
    @attachments = @construction_site.attachments

    @all_activities = PublicActivity::Activity.all
    set_1 = @all_activities.where(recipient_id: @construction_site.id, recipient_type: "ConstructionSite")
    set_2 = @all_activities.where(recipient_id: @construction_site.tasks.ids, recipient_type: "Task")
    @activities = PublicActivity::Activity.where(id: set_1.ids + set_2.ids).order('created_at DESC')
    @activities = @activities.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /construction_sites/new
  def new
    @construction_site = ConstructionSite.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /construction_sites/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /construction_sites
  # POST /construction_sites.json
  def create
    @construction_site = ConstructionSite.new(construction_site_params)

    respond_to do |format|
      if @construction_site.save
        create_participation
        @construction_site.create_activity action: 'create', recipient: @construction_site, owner: current_user
        format.html { redirect_to construction_sites_path, notice: 'construction_site was successfully created.' }
        format.json { render :show, status: :created, location: @construction_site }
      else
        format.html { render :new }
        format.json { render json: @construction_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /construction_sites/1
  # PATCH/PUT /construction_sites/1.json
  def update
    respond_to do |format|
      if @construction_site.update(construction_site_params)
        create_participation
        @construction_site.create_activity action: 'update', recipient: @construction_site, owner: current_user
        format.html { redirect_to construction_sites_path, notice: 'construction_site was successfully updated.' }
        format.json { render :show, status: :ok, location: @construction_site }
      else
        format.html { render :edit }
        format.json { render json: @construction_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /construction_sites/1
  # DELETE /construction_sites/1.json
  def destroy
    @construction_site.destroy
    respond_to do |format|
      format.html { redirect_to construction_sites_url, notice: 'construction_site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def about
    render("about")
  end

  def archive
    @construction_site = ConstructionSite.find(params[:id])
    @construction_site.archive = true
    @construction_site.save
    respond_to do |format|
      format.html { redirect_to :back, notice: 'construction_site was successfully archived' }
      format.js
    end
  end

  def add_participants
    create_participation
    respond_to do |format|
      format.html
      format.js
    end
  end

  def kick_user
    if current_user.manager?(@construction_site)
      @user = User.find(params[:user_id])
      if (@user != current_user)
        @construction_site.participations.where(user_id: @user).first.destroy
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Participation has been canceled successfully' }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Participation could not be canceled. You are manager of Project' }
          format.js
        end
      end
    else render_404
    end
  end

  def import
    require 'csv'
    CSV.foreach(params[:file].path, headers: true) do |row|
      if row[12].nil?
        desc = ""
      else desc = row[12]
      end
      if row[22].nil?
        number = ""
      else number = row[22]
      end
      if current_user.construction_sites.where(name: number + " - " + row[1] + " (" + row[5] + ")").empty?
        @construction_site = ConstructionSite.create(name: number + " - " + row[1] + " (" + row[5] + ")", customer_name: row[2], email: row[3], address: row[4], description: desc, user_id: current_user.id)
        create_participation
      end
    end
    redirect_to construction_sites_path
    flash.now[:message] = t("notice.import_csv")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_construction_site
      @construction_site = ConstructionSite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def construction_site_params
      params.require(:construction_site).permit(:name, :nic_name, :address, :customer_name, :email, :phone, :site_type, :area, :avatar, :customer_id, :user_id, :description, :archive, :emails, :vault, :public)
    end

    def find_construction_site
      @construction_site = ConstructionSite.where(id: params[:id]).first
      render_404 unless @construction_site
    end

    def check_hierarchy
      render_403 unless @construction_site.participations.where(user_id: current_user, construction_site_id: @construction_site).first.try(:role) == "manager"
    end

    def check_user
      unless @construction_site.public
        render_403 unless @construction_site.users.include?(current_user)
      end
    end

    def create_participation
      Participation.create(construction_site_id: @construction_site.id, role: "manager", user_id: current_user.id)
      unless params[:emails].blank?
        emails = params[:emails].split(/,\s?/)
        emails.each do |e|
          if !User.where(email: e.downcase).empty?
            user = User.where(email: e.downcase).first
            @participation = Participation.create(construction_site_id: @construction_site.id, role: "engineer", user_id: user.id)
            @participation.create_activity action: 'create', recipient: @construction_site, owner: user
          else
            user = User.new(email: e.downcase, password: "q4oRKWRQDdqz", password_confirmation: "q4oRKWRQDdqz")
            user.save
            @participation = Participation.create(construction_site_id: @construction_site.id, role: "engineer", user_id: user.id)
            ConstructionSiteMailer.invite_notification(@construction_site, user).deliver
            @participation.create_activity action: 'create', recipient: @construction_site, owner: user
          end
        end
      end
    end

end
