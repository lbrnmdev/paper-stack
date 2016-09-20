class TransaktionsController < ApplicationController
  before_action :authenticate_user!
  before_action :owner_user_of_transaktion, only: [:show, :destroy]
  before_action :owner_user_of_account, only: [:deposit, :withdrawal]

  def show
  end

  def deposit
    if @account.deposit(transaktion_params)
      flash[:success] = "Amount added!"
      redirect_to @account
    else
      flash[:danger] = "incomplete!"
    end
  end

  def withdrawal
    if @account.withdraw(transaktion_params)
      flash[:success] = "Amount deducted!"
      redirect_to @account
    else
      flash[:danger] = "incomplete!"
    end
  end

  def destroy
    parent_account = @transaktion.account
    @transaktion.destroy!
    flash[:success] = "Transaction deleted!"
    redirect_to parent_account
  end

  private

    def transaktion_params
      params.require(:transaktion).permit(:amount, :description)
    end

    def owner_user_of_transaktion
      @transaktion = Transaktion.find_by(id: params[:id])
      redirect_to authenticated_root_url if (@transaktion.nil? || @transaktion.account.user != current_user)
    end

    def owner_user_of_account
      @account = Account.find(params[:account_id])
      redirect_to authenticated_root_url if (@account.nil? || @account.user != current_user)
    end
end
