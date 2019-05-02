class Participation < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :user
  belongs_to :construction_site

  validate :validate_role, :validate_uniqueness_of_construction_site_and_user

  private

    def validate_role
      unless [ "manager", "engineer", "cad engineer" ].include?(role)
        errors.add(:role, "must have a correct value")
      end
    end

    def validate_uniqueness_of_construction_site_and_user
      if Participation.where(user_id: user.id, construction_site_id: construction_site.id).first
        errors.add(:base, "Participation for this user and construction site allready exists")
      end
    end

    def duplicates
      @p = Participation.all
      @p.each do |p|
        duplicates = Participation.where(user_id: p.user_id, construction_site_id: p.construction_site_id).to_a
        while duplicates.count > 1
          duplicates.shift.destroy
        end
      end
    end
end
