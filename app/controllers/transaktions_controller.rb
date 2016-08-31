class TransaktionsController < ApplicationController
  before_action :authenticate_user!

  # def create
  #   @transaktion = current_account.transaktions.build(transaktion_params)
  #   if @transaktion.save!
  #     flash[:success] = "Transaction added!"
  #     redirect_to current_account
  #   else
  #     flash[:danger] = "incomplete!"
  #   end
  # end

  def deposit
    @transaktion = current_account.transaktions.build(transaktion_params)
    if @transaktion.deposit!
      flash[:success] = "Amount added!"
      redirect_to current_account
    else
      flash[:danger] = "incomplete!"
    end
  end

  def withdrawal
    @transaktion = current_account.transaktions.build(transaktion_params)
    if @transaktion.withdrawal!
      flash[:success] = "Amount withdrawn!"
      redirect_to current_account
    else
      flash[:danger] = "incomplete!"
    end
  end

  def destroy
  end

  private

    def transaktion_params
      params.require(:transaktion).permit(:amount, :description, :transaktion_type)
    end
end
