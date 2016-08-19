class Transaktion < ActiveRecord::Base
  belongs_to :account
  enum transaktion_type: [:deposit, :withdrawal]
end
