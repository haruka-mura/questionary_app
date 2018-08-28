class Question < ApplicationRecord
  belongs_to :user
  has_many :question_tags
  has_many :tags, through: :question_tags

  attr_accessor :user, :question

  enum state: { accepting: 0, replied: 1 }

  def save(question, user)
    binding.pry
    question.user_id = user[:user]
    question.save
    binding.pry
  end
end
