class TransaktionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @transaktion = Transaktion.find(params[:id])
  end

  def deposit
    @account = Account.find(params[:account_id])
    # @transaktion = @account.transaktions.build(transaktion_params)
    # if @account.deposit(@transaktion)
    if @account.deposit(transaktion_params)
      flash[:success] = "Amount added!"
      redirect_to @account
    else
      flash[:danger] = "incomplete!"
    end
  end

  def withdrawal
    @account = Account.find(params[:account_id])
    # @transaktion = @account.transaktions.build(transaktion_params)
    if @account.withdraw(transaktion_params)
      flash[:success] = "Amount deducted!"
      redirect_to @account
    else
      flash[:danger] = "incomplete!"
    end
  end

  def destroy
    @transaktion = Transaktion.find(params[:id])
    parent_account = @transaktion.account
    @transaktion.destroy!
    flash[:success] = "Transaction deleted!"
    redirect_to parent_account
  end

  private

    def transaktion_params
      params.require(:transaktion).permit(:amount, :description)
    end
end
