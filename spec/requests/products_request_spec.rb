# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Products', type: :request do
  let(:event_user) { create(:event_user) }

  describe 'GET /search' do
    before do
      WebMock.enable!
      stub_request(
        :get, "https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?affiliateId=&applicationId=#{ENV['Rakuten_API_KEY']}&formatVersion=2&keyword=%E8%B5%A4%E3%81%A1%E3%82%83%E3%82%93%20%E3%83%9F%E3%83%AB%E3%82%AF"
      ).to_return(
        body: File.read(Rails.root.join('spec/fixtures/stub_api_response.json')),
        status: 200,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    it 'APIによる通信が成功すること' do
      sign_in event_user
      get search_path, params: { keyword: '赤ちゃん　ミルク' }
      expect(response).to have_http_status(:success)
    end
  end
end
