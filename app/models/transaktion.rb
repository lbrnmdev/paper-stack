class Transaktion < ActiveRecord::Base
  belongs_to :account
  enum transaktion_type: [:deposit, :withdrawal]
  validates :amount, presence:true, numericality: {greater_than_or_equal_to:0}
  validates_presence_of :account
  validates_presence_of :transaktion_type
  after_create :insert_transaktion
  before_destroy :reverse_on_account

  private

    def insert_transaktion
     if self.deposit?
       raise ActiveRecord::Rollback unless self.account.increment!(:balance, self.amount)
     end
     if self.withdrawal?
       raise ActiveRecord::Rollback unless self.account.decrement!(:balance, self.amount)
     end
    end

    # reverse transaction on parent account
    def reverse_on_account
      account.reverse(self)
    end
end
