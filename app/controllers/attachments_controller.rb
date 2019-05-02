class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :archive]
  before_filter :authenticate_user!, only: [:new, :create, :update, :edit, :archive]
  before_filter :find_attachment, only: [:show, :update, :archive, :edit, :download]
  before_filter :check_user, only: [:update, :edit, :archive, :download]

  def index
  end

  def show
    unless @attachment
      render_404 and return
    end
  end

  def new
    @attachment = Attachment.new
    respond_with(@attachment)
  end

  def edit
  end

  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.name = File.basename(@attachment.attachment.filename)
    respond_to do |format|
      if @attachment.save
        attach_user
        @construction_site = @attachment.construction_site
        @attachment.create_activity action: 'create', recipient: @construction_site, owner: current_user
        format.html { redirect_to :back, notice: 'attachment was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to :back, notice: 'attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @attachment.status == "archive"
    redirect_to :back
  end

  def download
    send_file(@attachment.attachment.path, type: @attachment.attachment.content_type, :disposition => 'inline', :url_based_filename => true, filename: @attachment.name, stream: 'true')
  end

  private
    def find_attachment
      @attachment = Attachment.where(id: params[:id]).first
      render_404 unless @attachment
    end

    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def attachment_params
      params.require(:attachment).permit(:name, :attachment, :user_id, :attachable_id, :attachable_type)
    end

    def check_user
      unless @attachment.construction_site.public
        render_403 unless @attachment.construction_site.users.include?(current_user)
      end
    end

    def attach_user
      @attachment.user_id = current_user.id
      @attachment.save
    end
end
