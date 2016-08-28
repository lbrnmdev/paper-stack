class Transaktion < ActiveRecord::Base
  belongs_to :account
  enum transaktion_type: [:deposit, :withdrawal]
  validates :amount, presence:true, numericality: {greater_than_or_equal_to:0}
  validates_presence_of :account
end
