class MultiPartQuote < ActiveRecord::Base
  has_many :quotes, ->{order(order: :asc)}
  belongs_to :author, class_name: 'Person', foreign_key: 'author'
end
