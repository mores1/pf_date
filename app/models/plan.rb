class Plan < ApplicationRecord
  belongs_to :user
  has_many :spot_plans, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true
  validates :body, presence: true
  
end
