require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario 'ユーザー登録ができること' do
    visit root_path
    click_link '仮のボタンです'
    expect(page).to have_http_status :ok
    click_link '登録する'
    fill_in 'user_email', with: 'foo@example.com'
    fill_in 'user[username]', with: 'foo'
    fill_in "user[babyname]", with: 'testbaby'
    fill_in 'user[password]', with: '111111'
    fill_in 'user[password_confirmation]', with: '111111'
    click_on '登録する'
    expect(page).to have_content 'アカウント登録が完了しました。'
  end
end