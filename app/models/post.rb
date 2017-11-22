class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :content, presence: true, length: {minimum: 6, maximum: 255}

  def belongs_to user
    self.user == user
  end
end
