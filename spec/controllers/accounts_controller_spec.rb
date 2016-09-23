require 'rails_helper'

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

  end

end
