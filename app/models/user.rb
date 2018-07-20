class User < ApplicationRecord
  before_save {self.email.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
                    
  has_secure_password
  
  
  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :like_relationships
  has_many :likes, through: :like_relatinships, source: :microposts
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  def feed_likes
    Micropost.where(self.like_ids)
  end
  
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
  
  def like(micropost)
    self.like_relationships.find_or_create_by(id: micropost.id)
  end
  
  def unlike(micropost)
    @like = self.like_relationships.find_by(id: micropost.id)
    @like.destroy if like
  end
  
  def like?(micropost)
    @like = self.like_relationships.find_by(id: micropost.id)
    self.likes.include?(micropost.id)
  end
  
  
  
  
end
