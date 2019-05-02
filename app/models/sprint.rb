class Sprint < ActiveRecord::Base
  belongs_to :user
  belongs_to :construction_site
  has_many :tasks
  has_many :metrics
end
