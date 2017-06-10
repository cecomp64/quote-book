class Quote < ActiveRecord::Base
  belongs_to :attribution, class_name: 'Person', foreign_key: :attribution
  belongs_to :author, class_name: 'Person', foreign_key: :author
end
