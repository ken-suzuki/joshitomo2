class Topic < ApplicationRecord
  mount_uploader :picture, PictureUploader
  
  scope :get_by_title, ->(title) {
  where("title like ?", "%#{title}%")
  }
  
  belongs_to :user
  has_many :posts, dependent: :delete_all
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :picture, presence: true
end
