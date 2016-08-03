class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
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

  private

    def account_params
      params.require(:account).permit(:name)
    end
end
