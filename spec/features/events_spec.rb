require 'rails_helper'

RSpec.feature "Events", type: :feature do
  let!(:login_user) { create(:login_user) }

  scenario 'ドラックでイベント登録ができること' do
    sign_in event_user
    visit calendar_path 
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


end
