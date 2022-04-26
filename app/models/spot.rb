class Spot < ApplicationRecord
  
  has_many :spot_comments, dependent: :destroy
  has_many :spot_plans, dependent: :destroy
  has_many :plans, through: :plan_spots
  belongs_to :user
  
  validates :title, presence: true
  validates :body, presence: true
  validates :star, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  
  has_one_attached :image_id
  acts_as_taggable
  
  def get_image_id
    (image_id.attached?) ? image_id : 'no_image.jpg'
  end
  
end
