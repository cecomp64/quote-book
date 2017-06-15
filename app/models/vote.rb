class Vote < ActiveRecord::Base
  belongs_to :multi_part_quote
  belongs_to :user
  belongs_to :band_name
end
