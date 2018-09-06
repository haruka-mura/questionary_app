class TagForm < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :name
end
