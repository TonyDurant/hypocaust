class Service < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user
  has_many	 :labours

  validates :picture, :name, :short_description, :body, :service_type, presence: true
  validates_length_of :name, :minimum => 0, :maximum => 50

  def to_param
    "#{id} #{link}".parameterize
  end
end
