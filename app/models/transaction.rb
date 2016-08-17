class Transaction < ActiveRecord::Base
  belongs_to :account
  enum transaction_type: [:deposit, :withdrawal]
end
