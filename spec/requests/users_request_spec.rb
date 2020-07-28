# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserAuthentications', type: :request do
  let(:user) { create(:user) }
  let!(:login_user) { create(:login_user) }
  let(:user_params) { attributes_for(:user) }
  let(:login_user_params) { attributes_for(:login_user) }
  let(:changed_username_params) { attributes_for(:login_user, username: 'changed_user') }
  # let(:changed_password_params) { attributes_for(:login_user, current_password: "testuser1", password: "changed_password", password_confirmation: "changed_password") }
  
  describe 'ログイン' do
    it 'ログインしてカレンダーページにリダイレクトされること' do
      post user_session_path, params: { user: login_user_params }
      expect(response).to redirect_to calendar_url
    end
  end
  
  describe 'ユーザー登録' do
    context 'パラメータが正しい場合' do
      subject { post user_registration_path, params: { user: user_params } }
      it 'ユーザー登録が成功すること' do
        expect { subject }.to change(User, :count).by 1
      end
      
      it 'カレンダーページにリダイレクトされること' do
        is_expected.to redirect_to calendar_url
      end
    end
  end
  
  describe 'ユーザーの更新' do
    subject { get edit_user_registration_path }
    context 'ログインしている場合' do
      before do
        sign_in login_user
      end
      it 'リクエストが成功し、更新できること' do
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

  # describe 'パスワードの更新' do
  #   # subject { get edit_user_path }
  #   context 'ログインしている場合' do
  #     before do
  #       sign_in login_user
  #     end
  #     it 'リクエストが成功し、更新できること' do
  #       # is_expected.to eq 200
  #       get edit_user_path
  #       patch update_password_user_path, params: { user: changed_password_params }
  #       # binding.pry
  #       # expect(response.status).to eq 200
  #       expect(response).to redirect_to user_url(login_user)
  #       expect(login_user.reload.password).to eq "changed_password"
  #     end
  #   end

  #   # context 'ログインしていない場合' do
  #   #   it 'ログイン画面にリダイレクトされること' do
  #   #     is_expected.to redirect_to new_user_session_url
  #   #   end
  #   # end
  # end
end
