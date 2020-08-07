require 'rails_helper'
require 'webmock/rspec'

RSpec.feature 'Events', type: :feature do
  let!(:event_user) { create(:event_user) }
  before do
    WebMock.enable!
    stub_request(
      :get, "https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?affiliateId=&applicationId=#{ENV['Rakuten_API_KEY']}&formatVersion=2&keyword=%E8%B5%A4%E3%81%A1%E3%82%83%E3%82%93%20%E3%83%9F%E3%83%AB%E3%82%AF"
    ).to_return(
      body: File.read("#{Rails.root}/spec/fixtures/stub_api_response.json"),
      status: 200,
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  scenario '楽天の検索結果が表示されること' do
    sign_in event_user
    visit calendar_path
    select 'ミルク'
    click_on '検索'
    expect(page).to have_http_status :ok
    expect(page).to have_content '検索結果'
  end
end
