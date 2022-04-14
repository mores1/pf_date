class Spot < ApplicationRecord
  
  belongs_to :user
  
  has_one_attached :image_id
  
  def get_image_id
    (image_id.attached?) ? image_id : 'no_image.jpg'
  end
  
end
