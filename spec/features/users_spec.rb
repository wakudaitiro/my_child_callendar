# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let!(:login_user) { create(:login_user) }

  scenario 'ユーザー登録ができること' do
    visit root_path
    click_link '仮のボタンです'
    expect(page).to have_http_status :ok
    click_link '登録する'
      expect {
        fill_in 'user_email', with: 'foo@example.com'
        fill_in 'user[username]', with: 'foo'
        fill_in 'user[babyname]', with: 'testbaby'
        fill_in 'user[password]', with: '111111'
        fill_in 'user[password_confirmation]', with: '111111'
        click_on '登録する'
      }.to change(User, :count).by(1)
    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  scenario 'パスワード変更ができること' do
    sign_in login_user
    visit calendar_path
    find('.profile-icon').click
    expect(page).to have_http_status :ok
    find('.setting').click
    click_on 'パスワードを変更'
    expect(page).to have_http_status :ok
    login_user.reload
    expect(login_user.valid_password?('testuser1')).to eq(true)
    expect(login_user.valid_password?('new_testuser1')).to eq(false)
    fill_in 'user[current_password]', with: 'testuser1'
    fill_in 'user[password]', with: 'new_testuser1'
    fill_in 'user[password_confirmation]', with: 'new_testuser1'
    click_on '変更する'
    login_user.reload
    expect(login_user.valid_password?('testuser1')).to eq(false)
    expect(login_user.valid_password?('new_testuser1')).to eq(true)
    expect(page).to have_content 'パスワードが変更されました'
  end
end
