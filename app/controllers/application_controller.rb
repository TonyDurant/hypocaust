class ApplicationController < ActionController::Base
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  include PublicActivity::StoreController
  #before_action :redirect_to_landing_page
  before_action :set_locale

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  private
    #def redirect_to_landing_page
    #  redirect_to '/'
    #end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
      #Rails.application.routes.default_url_options[:locale]= I18n.locale 
    end

    def configure_devise_permitted_parameters
      registration_params = [:name, :last_name, :avatar, :email, :password, :password_confirmation]
      if params[:action] == 'update'
        devise_parameter_sanitizer.for(:account_update) { 
          |u| u.permit(registration_params << :current_password)
        }
      elsif params[:action] == 'create'
        devise_parameter_sanitizer.for(:sign_up) { 
          |u| u.permit(registration_params) 
        }
      end
    end

    def render_403
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/403", :status => 403, :layout => false }
        format.json { render :json => { :type => "error", :message => "Error 403, you don't have permissions for this operation." } }
      end
    end

    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :status => 404, :layout => false }
        format.json { render :json => { :type => "error", :message => "Error 404, resourse was not found." } }
      end
    end
end
