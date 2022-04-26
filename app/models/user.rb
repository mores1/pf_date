class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :spots, dependent: :destroy
  has_many :spot_comments, dependent: :destroy
  has_many :spot_plans, dependent: :destroy
  has_many :cart_spots, dependent: :destroy
  
  validates :name, presence: true
  
  has_one_attached :image_id
  
  def get_image_id
    (image_id.attached?) ? image_id : 'no_image.jpg'
  end
  
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  
end