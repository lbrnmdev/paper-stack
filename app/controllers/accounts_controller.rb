class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :owner_user, only: [:show, :edit, :update, :destroy, :deposit, :withdraw]

  def index
    @accounts = current_user.accounts
  end

  def show
  end

  def new
    @account = current_user.accounts.new
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
  end

  def update
    if @account.update_attributes(account_params)
      flash[:success] = "Account info updated!"
      redirect_to @account
    else
      render 'edit'
    end
  end

  def destroy
    @account.destroy!
    flash[:success] = "Account deleted successfully!"
    redirect_to accounts_url
  end

  def deposit
    if @account.deposit(transaktion_params)
      flash[:success] = "Amount added!"
      redirect_to @account
    else
      flash[:danger] = "incomplete!"
    end
  end

  def withdraw
    if @account.withdraw(transaktion_params)
      flash[:success] = "Amount deducted!"
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

    def owner_user
      @account = Account.find_by(id: params[:id]) || Account.find_by(id: params[:account_id])
      redirect_to authenticated_root_url if (@account.nil? || @account.user != current_user)
    end
end
