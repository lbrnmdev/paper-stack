class Transaktion < ActiveRecord::Base
  belongs_to :account
  enum transaktion_type: [:deposit, :withdrawal]
  after_create :insert_transaktion
  before_destroy :destroy_transaktion

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

    # what if destroy action fails? i.e transaction on account successfully reversed but Transaktion isn't deleted?
    def destroy_transaktion
      unless self.destroyed?
        if self.deposit?
          # reverse
          raise ActiveRecord::Rollback unless self.account.decrement!(:balance, self.amount)
        end
        if self.withdrawal?
          # reverse
          raise ActiveRecord::Rollback unless self.account.increment!(:balance, self.amount)
        end
      end
    end
end
