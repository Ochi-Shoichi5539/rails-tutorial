require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  let!(:user) { create :user }

  describe "GET #new" do
    it "request succeeds" do
      get login_url
      expect(response).to have_http_status '200'
    end
  end

  describe "POST #create" do
    context 'when user is registered' do
      before do
        post login_url, params: { session: { account: user.account, password: user.password } }
      end

      it "request succeeds" do
        expect(response).to have_http_status '302'
      end

      it "login success message is displayed" do
        expect(flash[:notice]).to eq "ログインしました"
      end
    end

    context 'when user is unregistered' do
      before do
        post login_url, params: { session: { account: '', password: '' } }
      end

      it 'request succeeds' do
        expect(response).to have_http_status '200'
      end

      it "login failure message is displayed" do
        expect(flash[:alert]).to eq "無効なアカウントとパスワードの組み合わせです"
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      post login_url, params: { session: { account: user.account, password: user.password } }
      delete logout_path
    end

    it 'request succeeds' do
      expect(response).to have_http_status '302'
    end

    it 'session is deleted' do
      expect(session[:user_id]).to eq nil
    end

    it 'redirect to users_url' do
      expect(response).to redirect_to login_url
    end

    it "logout success message is displayed" do
      expect(flash[:notice]).to eq "ログアウトしました"
    end
  end
end
