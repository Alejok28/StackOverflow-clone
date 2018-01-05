# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :answers
  has_many :votes, as: :voteable

  validates :title, :body, presence: true

  def voted_by?(user)
    votes.exists?(user: user)
  end

end
