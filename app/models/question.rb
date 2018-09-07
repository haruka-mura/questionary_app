class Question < ApplicationRecord
  validates :subject, presence: true, length: { maximum: 200 }
  validates :content, presence: true

  belongs_to :user
  has_many :answers
  has_many :question_tags
  has_many :tags, through: :question_tags

  enum state: { accepting: 0, replied: 1 }

  scope :search_with_keyword, -> (keyword) { where("subject like :keyword OR content like :keyword",
                                  {keyword: "%#{sanitize_sql_like(keyword)}%"} ) }
end
