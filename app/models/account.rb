class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transaktions

  # deposit funds
  # def deposit(amount, description="")
  # # def deposit transaktion
  #   transaktion = self.transaktions.build(amount:amount, description:description)
  #   Account.transaction do
  #     transaktion.deposit!
  #     increment!(:balance, amount)
  #     # increment!(:balance, transaktion.amount)
  #   end
  # end

  # def deposit(amount, description="")
  # modify to always generate and save a whole new transaktion
  def deposit(transaktion_params={})
    transaktion_params = transaktion_params[:transaktion].attributes.inject({}){ |hash, (k, v)| hash.merge( k.to_sym => v )  } if !transaktion_params[:transaktion].nil?
    new_transaktion = transaktions.build(amount:transaktion_params[:amount], description:transaktion_params[:description])
    new_transaktion.deposit!
  end

  def withdraw(transaktion_params={})
    transaktion_params = transaktion_params[:transaktion].attributes.inject({}){ |hash, (k, v)| hash.merge( k.to_sym => v )  } if !transaktion_params[:transaktion].nil?
    new_transaktion = transaktions.build(amount:transaktion_params[:amount], description:transaktion_params[:description])
    new_transaktion.withdrawal!
  end

  # reverse transaktion
  # ToDo: raise error if none of the conditions are met
  def reverse transaktion
    decrement!(:balance, transaktion.amount) if transaktion.deposit?
    increment!(:balance, transaktion.amount) if transaktion.withdrawal?
  end
end
