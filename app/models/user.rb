class User < ApplicationRecord
  
  scope :get_by_name, ->(name) {
  where("name like ?", "%#{name}%")
  }

  scope :get_by_age, ->(age) {
  where(age: age)
  }
  
  scope :get_by_live, ->(live) {
  where("live like ?", "%#{live}%")
  }
  
  scope :get_by_hobby, ->(hobby) {
  where(hobby: hobby)
  }
  
  mount_uploader :image, ImageUploader
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :age, presence: true
  validates :hobby, presence: true
  validates :image, presence: true
  validates :pr, presence: true, length: { maximum: 300 }
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :topics,dependent: :destroy
  has_many :posts,dependent: :destroy
  
  has_many :favorites
  has_many :favoritings, through: :favorites, source: :topic
  
  has_many :messages,dependent: :destroy
  has_many :entries,dependent: :destroy
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(topic)
      self.favorites.find_or_create_by(topic_id: topic.id)
  end

  def unlike(topic)
    favorite = self.favorites.find_by(topic_id: topic.id)
    favorite.destroy if favorite
  end

  def liking?(topic)
    self.favoritings.include?(topic)
  end
  
end