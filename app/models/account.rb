class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transaktions

  def deposit(transaktion_params={})
    transaktion_params = transaktion_params[:transaktion].attributes.inject({}){ |hash, (k, v)| hash.merge( k.to_sym => v )  } if !transaktion_params[:transaktion].nil?
    new_transaktion = transaktions.build(amount:transaktion_params[:amount], description:transaktion_params[:description])
    begin
      new_transaktion.deposit!
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end

  def withdraw(transaktion_params={})
    transaktion_params = transaktion_params[:transaktion].attributes.inject({}){ |hash, (k, v)| hash.merge( k.to_sym => v )  } if !transaktion_params[:transaktion].nil?
    new_transaktion = transaktions.build(amount:transaktion_params[:amount], description:transaktion_params[:description])
    begin
      new_transaktion.withdrawal!
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end

  # reverse transaktion
  # ToDo: raise error if none of the conditions are met
  def reverse transaktion
    decrement!(:balance, transaktion.amount) if transaktion.deposit?
    increment!(:balance, transaktion.amount) if transaktion.withdrawal?
  end
end
