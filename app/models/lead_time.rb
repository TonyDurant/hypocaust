class LeadTime < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :construction_site
  belongs_to :user

  include PgSearch
  multisearchable :against => [:title, :start_date, :end_date, :created_at, :updated_at]
end
