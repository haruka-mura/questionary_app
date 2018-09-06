class TagForm
  include ActiveModel::Model
  attr_accessor :name, :question

  def save
    tags = name.split(/\s|　/)
    tags.each do |tag|
      question.tags << Tag.find_or_create_by(name: tag)
    end
  end
  # def save
  #   tag = Tag.new(name: name)
  #   question.tags << tag
  #   tag.save
  # end

  def update
    question.tags.clear
    tags = name.split(/\s|　/)
    tags.each do |tag|
      question.tags << Tag.find_or_create_by(name: tag)
    end
  end

  def show_tags
    @tags = []
    question.tags.each do |tag|
      @tags << tag.name
    end
    @tags = "#{@tags.join(" ")}"
  end
end
