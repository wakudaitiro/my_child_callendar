require 'rails_helper'

RSpec.describe "UserAuthentications", type: :request do
  let(:user) { create(:user) }
  let(:invalid_user) { create(:invalid_user)}
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:invalid_user) }

  describe 'ユーザーの登録' do
    context 'パラメータが正しい場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it 'ユーザー登録が成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'カレンダーページにリダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to calendar_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it 'エラーが表示されること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include "Username が入力されていません"
      end
    end

    describe 'GET #edit' do
      subject { get edit_user_registration_path }
      context 'ログインしている場合' do
        before do
          sign_in user
        end
        it 'リクエストが成功すること' do
          is_expected.to eq 200
        end
      end
      context 'ゲストの場合' do
        it 'リダイレクトされること' do
          is_expected.to redirect_to new_user_session_path
        end
      end
    end
  end
end