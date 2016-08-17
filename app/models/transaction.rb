class Transaction < ActiveRecord::Base
  belongs_to :account
  enum type: [:deposit, :withdrawal]
end
