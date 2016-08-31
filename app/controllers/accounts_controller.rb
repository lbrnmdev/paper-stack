class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts
  end

  def show
    @account = Account.find(params[:id])
    @transaktion = @account.transaktions.build
  end

  def new
    @account = Account.new
  end

  def create
    @account = current_user.accounts.build(account_params)
    if @account.save
      flash[:success] = "#{account_params[:name]} account created!"
      redirect_to accounts_url
    else
      render 'accounts/new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = "Account info updated!"
      redirect_to @account
    else
      render 'edit'
    end
  end

  def destroy
    Account.find(params[:id]).destroy
    flash[:success] = "Account deleted successfully!"
    redirect_to accounts_url
  end

  def deposit
    @account = Account.find(params[:id])
    if @account.deposit(transaktion_params)
      flash[:success] = "amount added!"
      redirect_to @account
    else
      flash[:danger] = "incomplete!"
    end
  end

  private

    def account_params
      params.require(:account).permit(:name)
    end

    def transaktion_params
      params.require(:transaktion).permit(:amount, :description)
    end
end
