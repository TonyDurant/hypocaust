class ServicesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :update, :edit, :destroy, :drafts]
  before_filter :find_service, only: [:show, :update, :destroy, :edit]
  before_filter :check_user, only: [:update, :edit, :destroy]
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  # GET /services
  # GET /services.json
  def index
    @services_raw = Service.where(service_type: 'service')
    @services = @services_raw.where(draft: false)
    @services_in_draft = Service.all.where(draft: true).order('created_at DESC')
    @services = @services.order('created_at DESC')
  end

  def drafts
    if current_user.try(:status) == 'admin'
      @services_raw = Service.all
      @services_in_draft = @services_raw.where(draft: true).order('created_at DESC')
    else render_403
    end
  end

  def out_of_the_box
    @services = Service.where(service_type: 'out_of_the_box').where(draft: false).order('created_at DESC')
    @services_in_draft = Service.all.where(draft: true).order('created_at DESC')
  end

  # GET /services/1
  # GET /services/1.json
  def show
    unless @service
      render_404 and return 
    end
  end

  # GET /services/new
  def new
    if current_user.try(:status) == 'admin'
      @service = Service.new
    else render_403
    end
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        attach_user
        name_to_translit
        format.html { redirect_to services_path, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        name_to_translit
        format.html { redirect_to services_path, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def welcome_page
    @services_raw = Service.where(service_type: 'service')
    @services = @services_raw.where(draft: false)
    @services_in_draft = Service.all.where(draft: true).order('created_at DESC')
    @services = @services.order('created_at DESC')
    render("welcome_page")
  end

  def contact_us
    render("contact_us")
  end

  def landing_page
    render layout: 'landing_page'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :short_description, :body, :picture, :service_type, :price, :draft)
    end

    def find_service
      @service = Service.where(id: params[:id]).first
      render_404 unless @service
    end

    def check_user
      render_403 unless @service.user == current_user || current_user.status == 'admin'
    end

    def attach_user
      @service.user_id = current_user.id
      @service.save
    end

    def name_to_translit
      @service.link = Translit.convert(@service.name, :english)
      @service.save
    end
end
