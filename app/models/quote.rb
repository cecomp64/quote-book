class Quote < ActiveRecord::Base
  belongs_to :attribution, class_name: 'Person', foreign_key: :attribution
  belongs_to :multi_part_quote, dependent: :destroy
  has_and_belongs_to_many :votes

  validates_presence_of :text, :attribution
  validates_uniqueness_of :text, case_sensitive: false

  SEARCH_VECTORS = [:attributed_to, :contains, :authored_by]
end
