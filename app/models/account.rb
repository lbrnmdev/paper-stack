class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transaktions
end
