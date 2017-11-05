class Task < ApplicationRecord
  belongs_to :user
  
  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10}
end