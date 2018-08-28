class Answer < ApplicationRecord
  validates :comment, presence: true

  belongs_to :question
  belongs_to :user
end
