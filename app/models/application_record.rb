class ApplicationRecord < ActiveRecord::Base
  include EnumI18n
  self.abstract_class = true
end
