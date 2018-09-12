class TagForm
  include ActiveModel::Model
  attr_accessor :name, :question

  def save
    question.tags = name.split(/\s|　/)&.map do |tag|
      Tag.find_or_create_by(name: tag)
    end
  end

  def show_tags
    question.tags.map(&:name).join(" ")
  end
end
