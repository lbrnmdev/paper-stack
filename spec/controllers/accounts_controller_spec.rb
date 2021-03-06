require 'rails_helper'

# TODO Implement testing for actions using invalid attributes

RSpec.describe AccountsController, type: :controller do

  # create users and accounts for testing
  let(:user) {create(:user)}
  let(:other_user) {create(:user, email: "other_user@example.com")}
  let(:account) {create(:account, user: user)}
  let(:other_users_account) {create(:account, user:other_user)}

  # Seems like controller testing is on it's way
  # out (assigns, render_template being deprecated) sooo..
  # TODO: refactor to only check for html status responses
  describe "GET #index" do
    context "while logged out" do
      it "redirects to the login template" do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context "while logged in" do
      let(:accounts) {create_list(:account, 5, user: user)}
      before do
        sign_in user
        get :index
      end
      it "renders the index page" do
        expect(response).to render_template :index
      end
      it "assigns user's accounts to @accounts" do
        expect(assigns(:accounts)).to match_array accounts
      end
    end
  end

  describe "GET #new" do
    context "while logged out" do
      it "returns http redirect" do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
        get :new
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #show" do
    context "while logged out" do
      it "returns http redirect" do
        get :show, id: account
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end

      it "returns http success when logged in user owns account" do
        get :show, id: account
        expect(response).to have_http_status(:success)
      end

      it "returns http redirect when logged in user doesn't own account" do
        get :show, id: other_users_account
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #edit" do
    context "while logged out" do
      it "returns http redirect" do
        get :edit, id: account
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end

      it "returns http success when logged in user owns account" do
        get :edit, id: account
        expect(response).to have_http_status(:success)
      end

      it "returns http redirect when logged in user doesn't own account" do
        get :edit, id: other_users_account
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "POST #create" do
    context "while logged out" do
      it "doesn't change number of accounts and returns http redirect" do
        expect{post :create, account: FactoryGirl.attributes_for(:account)}.to change{Account.count}.by(0)
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end

      it "increases number of accounts by 1" do
        expect{post :create, account: FactoryGirl.attributes_for(:account)}.to change{Account.count}.by(1)
      end
    end
  end

  describe "PUT #update" do
    context "while logged out" do
      it "doesn't modify account and returns http redirect" do
        expect{put :update, id:account, account: FactoryGirl.attributes_for(:account)}.to_not change{account.name}
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end

      it "modifies account" do
        put :update, id:account, account: FactoryGirl.attributes_for(:account, name: "new name")
        expect{account.reload}.to change{account.name}
        expect(account.reload.name).to eq("new name")
      end

      it "doesn't modify account belonging to another user" do
        put :update, id:other_users_account, account: FactoryGirl.attributes_for(:account, name: "new name")
        expect{account.reload}.to_not change{account.name}
        expect(account.reload.name).to_not eq("new name")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @to_be_deleted = create(:account, user:user)
    end
    context "while logged out" do
      it "doesn't delete account and returns http redirect" do
        expect{delete :destroy, id:@to_be_deleted}.to_not change{Account.count}
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end

      it "deletes account" do
        expect{delete :destroy, id:@to_be_deleted}.to change{Account.count}.by(-1)
      end

      it "doesn't delete account belonging to another user" do
        @other_users_to_be_deleted = create(:account, user:other_user)
        expect{delete :destroy, id:@other_users_to_be_deleted}.to_not change{Account.count}
      end
    end
  end

  describe "PATCH #deposit" do
    context "while logged out" do
      it "doesn't make deposit and returns http redirect" do
        expect {patch :deposit, id:account, :transaktion=>{amount:5, description:"not logged in"}}.to_not change{account.balance}
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end

      it "doesn't make deposit on account belonging to another user" do
        expect {patch :deposit, id:other_users_account, :transaktion=>{amount:5, description:"account belongs to other_user"}}.to_not change{account.balance}
      end

      it "makes deposit" do
        expect {patch :deposit, id:account, :transaktion=>{amount:5, description:"account belongs user"} }.to change{account.reload.balance}.by(5)
      end
    end
  end

  describe "PATCH #withdraw" do
    context "while logged out" do
      it "doesn't make withdrawal and returns http redirect" do
        expect {patch :withdraw, id:account, :transaktion=>{amount:5, description:"not logged in"}}.to_not change{account.balance}
        expect(response).to have_http_status(:redirect)
      end
    end

    context "while logged in" do
      before do
        sign_in user
      end

      it "doesn't make withdrawal on account belonging to another user" do
        expect {patch :withdraw, id:other_users_account, :transaktion=>{amount:5, description:"account belongs to other_user"}}.to_not change{account.balance}
      end

      it "makes withdrawal" do
        expect {patch :withdraw, id:account, :transaktion=>{amount:5, description:"account belongs user"} }.to change{account.reload.balance}.by(-5)
      end
    end
  end

end
