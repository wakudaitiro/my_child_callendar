require 'rails_helper'
require 'webmock/rspec'

RSpec.feature 'Events', type: :feature do
  let!(:event_user) { create(:event_user) }
  before do
    WebMock.enable!
    stub_request(
      :get, 'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706'
    ).with(
      query: { 'affiliateId' => '', 'applicationId' => (ENV['Rakuten_API_KEY']).to_s, 'formatVersion' => 2, 'keyword' => '赤ちゃん　ミルク' } # rubocop:disable Style/LineLength
    ).to_return(
      body: File.read(Rails.root.join('spec/fixtures/stub_api_response.json')),
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
