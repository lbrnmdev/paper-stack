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
      transaktion.withdrawal!
      decrement!(:balance, amount)
    end
  end

  # reverse transaktion
  # ToDo: raise error if none of the conditions are met
  def reverse transaktion
    decrement!(:balance, transaktion.amount) if transaktion.deposit?
    increment!(:balance, transaktion.amount) if transaktion.withdrawal?
  end
end
