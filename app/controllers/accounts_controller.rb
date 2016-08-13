class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts
  end

  def show
    @account = Account.find(params[:id])
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

  private

    def account_params
      params.require(:account).permit(:name)
    end
end
