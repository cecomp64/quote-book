class Quote < ActiveRecord::Base
  belongs_to :attribution, class_name: 'Person', foreign_key: :attribution
  belongs_to :multi_part_quote, dependent: :destroy
  has_many :votes

  validates_presence_of :text, :attribution

  SEARCH_VECTORS = [:attributed_to, :contains, :bands_named, :named_by, :authored_by]
end
