class Person < ActiveRecord::Base
  has_many :quotes, foreign_key: :attribution
  has_many :entries, class_name: 'Quote', foreign_key: :author

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
end
