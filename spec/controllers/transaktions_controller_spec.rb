require 'rails_helper'

RSpec.describe TransaktionsController, type: :controller do
  # create users, accounts and transaktions for testing
  let(:user) {create(:user)}
  let(:other_user) {create(:user, email: "other_user@example.com")}
  let(:account) {create(:account, user: user)}
  let(:other_users_account) {create(:account, user:other_user)}
  let(:transaktion) {create(:transaktion, account: account)}
  let(:other_users_transaktion) {create(:transaktion, account: other_users_account)}

  describe "GET #show" do
    context "while logged out" do
      it "returns http redirect" do
        get :show, id: transaktion
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end

      it "returns http redirect if not owner user" do
        get :show, id: other_users_transaktion
        expect(response).to have_http_status(:redirect)
      end

      it "returns http success" do
        get :show, id: transaktion
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @transaktion_to_be_deleted = create(:transaktion, account: account)
    end

    context "while logged out" do
      it "doesn't delete transaktion" do
        expect{ delete :destroy, id: @transaktion_to_be_deleted }.to_not change{Transaktion.count}
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end
      it "doesn't delete transaktion belonging to different user" do
        @other_transaktion_to_be_deleted = create(:account, user:other_user)
        expect{ delete :destroy, id: @other_transaktion_to_be_deleted }.to_not change{Transaktion.count}
      end
      it "deletes transaktion" do
        expect{ delete :destroy, id: @transaktion_to_be_deleted }.to change{Transaktion.count}.by(-1)
      end
    end
  end

end
