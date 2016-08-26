module AccountsHelper

  # sets the account currently being interacted with
  def set_current_account account
    session[:account_id] = account.id
  end

  # returns the account currently being interacted with
  def current_account
    @current_account ||= Account.find_by(id: session[:account_id])
  end
end
