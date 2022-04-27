require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let!(:user) { create :user }

  before do
    post login_path, params: { session: { account: user.account, password: user.password } }
  end

  describe 'GET #index' do
    it 'request succeeds' do
      get users_url
      expect(response).to have_http_status '200'
    end

    it 'id is displayed' do
      get users_url
      expect(response.body).to include user.id.to_s
    end

    it 'account is displayed' do
      get users_url
      expect(response.body).to include user.account
    end

    it 'created_at is displayed' do
      get users_url
      expect(response.body).to include user.created_at.to_s
    end

    it 'updated_at is displayed' do
      get users_url
      expect(response.body).to include user.updated_at.to_s
    end
  end

  describe 'GET #show' do
    context 'when user exists' do
      it 'request succeeds' do
        get user_url user.id
        expect(response).to have_http_status '200'
      end

      it 'account is displayed' do
        get user_url user.id
        expect(response.body).to include user.account
      end
    end

    context 'when user does not exist' do
      it 'RecordNotFound error is displayed' do
        expect do
          get user_url user.id = 0
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #new' do
    it 'request succeeds' do
      get new_user_url
      expect(response).to have_http_status '200'
    end
  end

  describe 'GET #edit' do
    it 'request succeeds' do
      get edit_user_url user
      expect(response).to have_http_status '200'
    end

    it 'account is displayed' do
      get edit_user_url user
      expect(response.body).to include user.account
    end
  end

  describe 'POST #create' do
    context 'when account or password is not empty' do
      it 'request succeeds' do
        post users_url, params: { user: attributes_for(:user) }
        expect(response).to have_http_status '302'
      end

      it 'user is registered' do
        expect do
          post users_url, params: { user: attributes_for(:user) }
        end.to change{ User.count }.by(1)
      end

      it 'redirect to page of created user' do
        post users_url, params: { user: attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end

    context 'when account or password is empty' do
      it 'return 422 status code' do
        post users_url, params: { user: attributes_for(:user, account: '', password: '') }
        expect(response).to have_http_status '422'
      end

      it 'user is not registered' do
        expect do
          post users_url, params: { user: attributes_for(:user, account: '', password: '') }
        end.to_not change{ User.count }
      end
    end
  end

  describe 'PUT #update' do
    context 'when account or password is not empty' do
      it 'request succeeds' do
        put user_url user, params: { user: attributes_for(:user) }
        expect(response).to have_http_status '302'
      end

      it 'account is updated' do
        expect do
          put user_url user, params: { user: attributes_for(:user, account: 's_ochi@ga-tech.co.jp') }
        end.to change{ User.find(user.id).account }.from(user.account).to('s_ochi@ga-tech.co.jp')
      end

      it 'redirect to page of updated user' do
        put user_url user, params: { user: attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end

    context 'when account is empty' do
      it 'return 422 status code' do
        put user_url user, params: { user: attributes_for(:user, account: '') }
        expect(response).to have_http_status '422'
      end

      it 'user is not updated' do
        expect do
          put user_url user, params: { user: attributes_for(:user, account: '') }
        end.to_not change{ User.count }
      end
    end

    context 'when password is empty' do
      it 'request succeeds' do
        put user_url user, params: { user: attributes_for(:user, password: '') }
        expect(response).to have_http_status '302'
      end

      it 'account is updated' do
        expect do
          put user_url user, params: { user: attributes_for(:user, account: 's_ochi@ga-tech.co.jp') }
        end.to change{ User.find(user.id).account }.from(user.account).to('s_ochi@ga-tech.co.jp')
      end

      it 'password is not updated' do
        expect do
          put user_url user, params: { user: attributes_for(:user, account: '') }
        end.to_not change{ User.find(user.id).password }
      end

      it 'redirect to page of updated user' do
        put user_url user, params: { user: attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'request succeeds' do
      delete user_url user
      expect(response).to have_http_status '302'
    end

    it 'user is deleted' do
      expect do
        delete user_url user
      end.to change{ User.count }.by(-1)
    end

    it 'redirect to users_url' do
      delete user_url user
      expect(response).to redirect_to users_url
    end
  end
end