class Comment < ActiveRecord::Base
  include PublicActivity::Model
  #tracked owner: Proc.new{ |controller, model| controller.current_user }, recipient: :commentable

  include PgSearch
  multisearchable :against => [:body, :created_at, :updated_at]
  #validates :body, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many   :comments, as: :commentable
  has_many   :tasks, as: :taskable
  has_many   :link_thumbnails

  def construction_site
    return self.commentable if self.commentable.is_a?(ConstructionSite)
    self.commentable.construction_site
  end

  def primary_comment
    return self if self.commentable.is_a?(ConstructionSite)
    return self if self.commentable.is_a?(Task)
    self.commentable.primary_comment
  end
end
