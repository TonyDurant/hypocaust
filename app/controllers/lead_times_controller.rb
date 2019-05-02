class LeadTimesController < ApplicationController
  before_action :set_lead_time, only: [:show, :edit, :update, :destroy]

  def index
    @lead_times = LeadTime.all
  end

  def show
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Labour was successfully created.' }
      format.json { head :no_content }
    end
  end

  def new
    @lead_time = LeadTime.new
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Labour was successfully created.' }
      format.json { head :no_content }
    end
  end

  def edit
  end

  def create
    @lead_time = LeadTime.new(lead_time_params)

    respond_to do |format|
      if @lead_time.save
        @construction_site = @lead_time.construction_site
        @lead_times = @construction_site.lead_times

        @lead_time_data = []
        @construction_site.lead_times.order('title DESC').each do |lead_time|
          @lead_time_data << [lead_time.construction_site.name + ": " + lead_time.title, lead_time.start_date, lead_time.end_date]
        end
        @lead_times = @construction_site.lead_times.order('title DESC')

        @lead_time.create_activity action: 'create', recipient: @construction_site, owner: current_user
        format.html { redirect_to :back, notice: 'lead_time was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.json { render json: @lead_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lead_times/1
  # PATCH/PUT /lead_times/1.json
  def update
    respond_to do |format|
      if @lead_time.update(lead_time_params)
        format.html { redirect_to :back, notice: 'lead_time was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead_time }
      else
        format.html { render :edit }
        format.json { render json: @lead_time.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lead_time.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Labour was successfully created.' }
      format.json { head :no_content }
    end
  end

  private
    def set_lead_time
      @lead_time = LeadTime.find(params[:id])
    end

    def lead_time_params
      params.require(:lead_time).permit(:title, :user_id, :construction_site_id, :start_date, :end_date)
    end
end
