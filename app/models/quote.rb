class Quote < ActiveRecord::Base
  belongs_to :attribution, class_name: 'Person', foreign_key: :attribution
  belongs_to :author, class_name: 'Person', foreign_key: :author

  validates_presence_of :text
  validates_uniqueness_of :text, case_sensitive: false
end
