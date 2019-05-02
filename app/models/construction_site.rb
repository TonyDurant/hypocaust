class ConstructionSite < ActiveRecord::Base
  include PublicActivity::Model
  #tracked owner: Proc.new{ |controller, model| controller.current_user }, recipient: @construction_site

  validates :name, :address, :customer_name, :email, :description, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  validates :area, :numericality => { :greater_than => 33, :less_than => 100000 }, allow_nil: true

  has_many :participations, :dependent => :destroy
  has_many :users, :through => :participations
  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  has_many :sprints, :dependent => :destroy
  has_many :lead_times, :dependent => :destroy
  has_many :attachments, as: :attachable

  include PgSearch
  multisearchable :against => [:name, :address, :customer_name, :email, :phone, :area, :description, :created_at, :updated_at, :site_type, :vault, :public, :archive]
  pg_search_scope :search, against: [:name, :address, :customer_name, :email, :phone, :area, :description, :created_at, :updated_at, :site_type, :vault, :public, :archive],
    using: {tsearch: {dictionary: "english", dictionary: "russian", :prefix => true, :any_word => true}},
    associated_against: {users: :email, comments: :body, tasks: [:name, :desc]}
    #using: :trigram

  def construction_site
    self
  end

  def self.text_search(query)
    if query.present?
      PgSearch.multisearch(query)
    else
      #all.where(archive: false)
    end
  end

  def data_gantt
    ary = []
    self.tasks.where("state = ? OR state = ?", "in progress", "done").each do |task|
      end_time = task.start_time + task.duration.hours
      ary << [task.name, task.start_time, end_time]
    end
    if ary.empty?
      nil
    else
      ary
    end
  end

  def attachments?
    a = []
    self.tasks.each do |t|
      if !t.attachments.empty?
        a << t.attachments
      end
    end
    Attachment.where(attachable_type: "ConstructionSite", attachable_id: self.id).each do |att|
      a << att
    end
    a.empty?
  end

  def attachments
    a = []
    self.tasks.each do |t|
      if !t.attachments.empty?
        t.attachments.each do |attachment|
          a << attachment
        end
      end
    end
    Attachment.where(attachable_type: "ConstructionSite", attachable_id: self.id).each do |att|
      a << att
    end
    a
  end

end
