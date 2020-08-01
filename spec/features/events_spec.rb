require 'rails_helper'

RSpec.feature "Events", type: :feature do
  let!(:event_user) { create(:event_user) }

  # scenario 'ドラックでイベント登録ができること' do
  #   sign_in event_user
  #   visit calendar_path
  #   sleep 2.0
  #   source = page.find("#calendar")
  #   save_and_open_page
  #   target = page.find("#fruit-#{orange.id}")



    # click_link '仮のボタンです'
    # expect(page).to have_http_status :ok
    # click_link '登録する'
    #   expect {
    #     fill_in 'user_email', with: 'foo@example.com'
    #     fill_in 'user[username]', with: 'foo'
    #     fill_in 'user[babyname]', with: 'testbaby'
    #     fill_in 'user[password]', with: '111111'
    #     fill_in 'user[password_confirmation]', with: '111111'
    #     click_on '登録する'
    #   }.to change(User, :count).by(1)
    # expect(page).to have_content 'アカウント登録が完了しました。'
  # end
  
  scenario '楽天の検索ができること' do
    sign_in event_user
    visit calendar_path
    select 'おむつ'
    click_on '検索'
    expect(page).to have_http_status :ok
    binding.pry
    expect(page).to have_content '検索結果'

  end

end
