class Task < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }, recipient: :construction_site

  validates :duration, :numericality => { :greater_than => 0 }

  belongs_to :user
  belongs_to :sprint
  belongs_to :construction_site
  belongs_to :taskable, polymorphic: true

  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable

  include PgSearch
  multisearchable :against => [:name, :desc, :state, :start_time, :duration, :end_time, :created_at, :updated_at]

  def sprint_name
    self.sprint.name
  end

  def get_image
    if !URI.extract(self.desc, "http").select{ |l| l[/\.(?:gif|png|jpe?g)\b/]}[0] = nil
      URI.extract(self.desc).select{ |l| l[/\.(?:gif|png|jpe?g)\b/]}[0]
    else
      false
    end
  end

end
