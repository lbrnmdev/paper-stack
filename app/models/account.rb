class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transaktions

  # deposit funds
  def deposit(amount, description="")
    transaktion = self.transaktions.build(amount:amount, description:description)
    Account.transaction do
      transaktion.deposit!
      increment!(:balance, amount)
    end
  end

  # withdraw funds
  def withdraw(amount, description="")
    transaktion = self.transaktions.build(amount:amount, description:description)
    Account.transaction do
      transaktion.withdraw!
      decrement!(:balance, amount)
    end
  end
end
