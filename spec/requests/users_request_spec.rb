# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserAuthentications', type: :request do
  let!(:user) { create(:user) }
  let!(:evnet) { create(:event, user_id: user.id) }
  let!(:login_user) { create(:login_user) }
  let(:user_params) { attributes_for(:user) }
  let(:login_user_params) { attributes_for(:login_user) }
  let(:invalid_user_params) { attributes_for(:user, email: '') }
  let(:nologin_user_params) { attributes_for(:login_user, email: 'abc@a') }
  let(:changed_username_params) { attributes_for(:login_user, username: 'changed_user') }

  describe 'ログイン' do
    context 'パラメーターが正しい場合' do
      it 'ログインしてカレンダーページにリダイレクトされること' do
        post user_session_path, params: { user: login_user_params }
        expect(response).to redirect_to calendar_url
      end
    end

    context 'メールアドレスが異なる場合' do
      it 'ページ遷移しないこと' do
        post user_session_path, params: { user: nologin_user_params }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'ユーザー登録' do
    context 'パラメータが正しい場合' do
      it 'ユーザー登録が成功、カレンダーページへリダクレくとされること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
        expect(response).to redirect_to calendar_url
      end
    end

    context 'メールアドレスの入力がない場合' do
      it 'ユーザー登録されない、ページ遷移しないこと' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to change(User, :count).by 0
        expect(response.status).to eq 200
      end
    end
  end

  describe 'ユーザー削除' do
    context 'ログインしている場合' do
      it 'ユーザーが削除され,トップページにリダイレクトされること' do
        sign_in login_user
        expect do
          delete user_registration_path, params: { user: login_user_params }
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to root_url
      end

      it 'ユーザー削除と同時に関連したイベントが削除されること' do
        sign_in user
        expect { user.destroy }.to change { Event.count }.by(-1)
      end
    end

    context 'ログインしていない場合' do
      it '削除ができず、ログイン画面にリダイレクトされること' do
        expect do
          delete user_registration_path, params: { user: login_user_params }
        end.to change(User, :count).by 0
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'ユーザーの更新' do
    subject { get edit_user_registration_path }
    context 'ログインしている場合' do
      before do
        sign_in login_user
      end
      it 'リクエストが成功し、ユーザーネームが更新できること' do
        is_expected.to eq 200
        patch user_registration_path, params: { user: changed_username_params }
        expect(response).to redirect_to user_url(login_user)
        expect(login_user.reload.username).to eq 'changed_user'
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        is_expected.to redirect_to new_user_session_url
      end
    end
  end
end
