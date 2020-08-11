# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  describe 'バリデーションの確認' do
    it 'emailが重複する場合のバリデーション' do
      same_email_user = FactoryBot.build(:user, email: 'test_1@example.com')
      same_email_user.valid?
      expect(same_email_user).to_not be_valid
      expect(same_email_user.errors[:email]).to include('は既に使用されています。')
    end

    it 'ユーザーネームがない場合のバリデーション' do
      no_name_user = FactoryBot.build(:noname_user)
      no_name_user.valid?
      expect(no_name_user).to_not be_valid
      expect(no_name_user.errors[:username]).to include('が入力されていません。')
    end

    it 'パスワードが5文字以下の場合のバリデーション' do
      testuser1 = FactoryBot.build(:user, password: 'a' * 6)
      expect(testuser1).to be_valid
      testuser2 = FactoryBot.build(:user, password: 'a' * 5)
      testuser2.valid?
      expect(testuser2).to_not be_valid
      expect(testuser2.errors[:password]).to include('は6文字以上に設定して下さい。')
    end
  end
end
