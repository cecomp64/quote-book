class Vote < ActiveRecord::Base
  belongs_to :multi_part_quote
  belongs_to :user
end
