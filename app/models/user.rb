class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :services
  has_many :posts
  has_many :construction_sites, :through => :participations
  has_many :participations
  has_many :comments
  has_many :tasks
  has_many :sprints
  has_many :attachments
  has_many :favorites
  has_many :lead_times

  def has_right_to_see?(item)
    if item.try(:construction_site)
      if item.construction_site.users.include?(self)
        true
      end
    end
  end

  def manager?(construction_site)
    @construction_site = construction_site
    unless self.participations.empty?
      if self.participations.where(construction_site_id: @construction_site.id).first.role == "manager"
        true
      else
        false
      end
    else
      false
    end
  end

  def construction_sites_with_tasks
    with_tasks = []
    unless self.construction_sites.empty?
      self.construction_sites.where(archive: false).each do |cs|
        unless cs.tasks.where(state: "todo").empty?
          with_tasks << cs
        end
      end
      if with_tasks.empty?
        self.construction_sites.where(archive: false).take(5)
      else
        with_tasks
      end
    end
  end

end
