require 'rails_helper'

RSpec.describe "LogsOfActiveRecordMethodWithQueries", type: :request do
  let!(:user) { create :user }

  before do
    post login_path, params: { session: { account: user.account, password: user.password } }
  end

  describe "GET #index" do
    it 'request succeeds' do
      get logs_of_active_record_method_with_query_url
      expect(response).to have_http_status '200'
    end
  end
end
