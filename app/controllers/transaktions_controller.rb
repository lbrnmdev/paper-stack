class TransaktionsController < ApplicationController
  before_action :authenticate_user!
  before_action :owner_user, only: [:show, :destroy]

  def show
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

    def owner_user
      @transaktion = Transaktion.find_by(id: params[:id])
      redirect_to authenticated_root_url if (@transaktion.nil? || @transaktion.account.user != current_user)
    end
end
