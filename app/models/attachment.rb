class Attachment < ActiveRecord::Base
  include PublicActivity::Model

  mount_uploader :attachment, AttachmentUploader
  belongs_to :user
  belongs_to :attachable, polymorphic: true
  belongs_to :construction_site

  include PgSearch
  multisearchable :against => [:name, :attachment, :attachable_type, :created_at, :updated_at]

  def to_param
    "#{id} #{name}".parameterize
  end

  def construction_site
    return self.attachable if self.attachable.is_a?(ConstructionSite)
    self.attachable.construction_site
  end
end
