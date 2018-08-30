class Question < ApplicationRecord
  validates :subject, presence: true, length: { maximum: 200 }
  validates :content, presence: true

  belongs_to :user
  has_many :answers
  has_many :question_tags
  has_many :tags, through: :question_tags

  # attr_accessor :keyword

  enum state: { accepting: 0, replied: 1 }

  def self.keyword_search(keyword)
    questions = Question.all

    return questions if keyword.nil?

    scope = questions.where("subject like?", "%#{sanitize_sql_like(keyword)}%").or(questions.where("content like?", "%#{sanitize_sql_like(keyword)}%"))
    if scope.nil?
      questions
    else
      scope
    end
  end
end
