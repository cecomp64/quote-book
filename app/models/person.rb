class Person < ActiveRecord::Base
  has_many :quotes, foreign_key: :attribution
  has_many :entries, class_name: 'Quote', foreign_key: :author
end
