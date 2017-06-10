class Vote < ActiveRecord::Base
  has_and_belongs_to_many :quotes
  has_and_belongs_to_many :people
end
