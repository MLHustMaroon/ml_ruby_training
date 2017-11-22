class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :rates

  def is_parent_comment?
    self.parent.nil?
  end

  def belongs_to? user
    self.user == user
  end

  def rate
    star = 0
    self.rates.each do |rate|
      star += rate.value
    end
    if self.rates.count > 0
       star / self.rates.count
    else
       star
    end
  end

  def rated_by_user(user)
    self.rates.find_by(user: user)
  end
end
