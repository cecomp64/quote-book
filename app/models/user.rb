class User < ActiveRecord::Base
  has_many :votes
  belongs_to :person

  validates_uniqueness_of :person_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
