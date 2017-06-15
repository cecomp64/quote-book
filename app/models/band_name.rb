class BandName < ActiveRecord::Base
  belongs_to :person

  validates_presence_of :person_id
  validates_uniqueness_of :name, case_sensitive: false
end
