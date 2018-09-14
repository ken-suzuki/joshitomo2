class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  
  has_many :replies,class_name:'Post',foreign_key: :parent_id,dependent: :destroy
  belongs_to :parent,class_name:'Post',optional:true
  
  validates :user_id, presence: true
  validates :topic_id, presence: true
  validates :comment, presence: true, length: { maximum: 255 }
  
  def self.ranking
    self.group(:topic_id).order('count_topic_id DESC').limit(5).count(:topic_id)
  end
  
  def self.rankingtop
    self.group(:topic_id).order('count_topic_id DESC').count(:topic_id)
  end
end
