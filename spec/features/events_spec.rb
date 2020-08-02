require 'rails_helper'

RSpec.feature "Events", type: :feature do
  let!(:event_user) { create(:event_user) }

  scenario '楽天の検索結果が表示されること' do
    sign_in event_user
    visit calendar_path
    select 'おむつ'
    click_on '検索'
    expect(page).to have_http_status :ok
    expect(page).to have_content '検索結果'
  end
end