class Spot < ApplicationRecord
  
  has_many :spot_comments, dependent: :destroy
  belongs_to :user
  has_one_attached :image_id
  acts_as_taggable
  
  def get_image_id
    (image_id.attached?) ? image_id : 'no_image.jpg'
  end
  
end
