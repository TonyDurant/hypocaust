class Post < ActiveRecord::Base
  #include PublicActivity::Model
  #tracked owner: Proc.new{ |controller, model| controller.current_user }

  validates :title, :body, presence: true

  belongs_to :user
  belongs_to :blog
  has_many :comments, as: :commentable
  has_many :favorites, as: :favorable, dependent: :destroy

  #searchable do
  #  text    :title, :body, :link
  #  time    :created_at
  #  #integer :user_id
  #  text  :posting_date
  #end

  def to_param
    "#{id} #{link}".parameterize
  end

  def posting_date
    created_at.strftime('%d %b %Y')
  end

end
