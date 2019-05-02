class CompaniesController < ApplicationController
  respond_to :html
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:index, :new, :update, :edit, :destroy]
  before_filter :check_user, only: [:index, :show, :update, :edit, :destroy]  

  def index
    @companies = Company.all
    respond_with(@companies)
  end

  def show
    respond_with(@company)
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to :back, notice: t("company.mail_notification") }
        format.json { render :show, status: :created, location: @construction_site }
        CompanyMailer.new_company(@company).deliver
      else
        format.html { redirect_to :back, notice: t("company.mail_notification_error") }
        format.json { render json: @construction_site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @company.update(company_params)
    respond_with(@company)
  end

  def destroy
    @company.destroy
    respond_with(@company)
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :email, :desc)
    end

    def check_user
      render_403 unless @company.user == current_user || @current_user.status == 'admin'
    end
end
