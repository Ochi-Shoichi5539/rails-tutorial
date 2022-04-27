require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }

  describe 'account and password validation' do
    context 'when both account and password are set' do
      it 'account and password are valid' do
        expect(user.valid?).to eq(true)
      end
    end

    context 'when account is empty' do
      let(:user) { build :user, account: '' }
      it "account can't be blank" do
        user.valid?
        expect(user.errors[:account]).to include("を入力してください")
      end
    end

    context 'when password is empty' do
      let(:user) { build :user, password: '' }
      it "password can't be blank" do
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
    end
  end
end
