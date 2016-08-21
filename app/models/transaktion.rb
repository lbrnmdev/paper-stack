class Transaktion < ActiveRecord::Base
  belongs_to :account
  enum transaktion_type: [:deposit, :withdrawal]
  after_create :insert_transaktion

  private

    def insert_transaktion
      if self.deposit?
        raise ActiveRecord::Rollback unless self.account.increment!(:balance, self.amount)
      end
      if self.withdrawal?
        raise ActiveRecord::Rollback unless self.account.decrement!(:balance, self.amount)
      end
    end

    def update_transaktion
    end

    def destroy_transaktion
    end
end
