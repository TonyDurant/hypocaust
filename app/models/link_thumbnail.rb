class LinkThumbnail < ActiveRecord::Base
  belongs_to :comment

  include PgSearch
  multisearchable :against => [:name, :desc, :image, :url, :created_at, :updated_at]

  def construction_site
    return self.comment.commentable if self.comment.commentable.is_a?(ConstructionSite)
    self.comment.commentable.construction_site
  end
end
