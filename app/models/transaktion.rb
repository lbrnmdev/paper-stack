class Transaktion < ActiveRecord::Base
  belongs_to :account
  enum transaktion_type: [:deposit, :withdrawal]
  validates :amount, presence:true, numericality: {greater_than_or_equal_to:0}
  validates_presence_of :account
  before_destroy :reverse_on_account

  private

    # reverse transaction on parent account
    def reverse_on_account
      account.reverse(self)
    end
end
