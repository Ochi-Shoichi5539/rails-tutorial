require 'rails_helper'

RSpec.describe "Logs", type: :request do
  let!(:user) { create :user }

  before do
    post login_path, params: { session: { account: user.account, password: user.password } }
  end

  describe "GET #index" do
    it 'request succeeds' do
      get logs_url
      expect(response).to have_http_status '200'
    end
  end
end
