class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :spots, dependent: :destroy
  has_one_attached :image_id
  
  def get_image_id
    (image_id.attached?) ? image_id : 'no_image.jpg'
  end
  
  
end
