class Person < ActiveRecord::Base
  has_many :entries, class_name: 'MultiPartQuote', foreign_key: :author
  has_and_belongs_to_many :votes
  has_many :band_names

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false

  def quotes
    MultiPartQuote.joins(:quotes).where(quotes: {attribution: self})
  end
end
