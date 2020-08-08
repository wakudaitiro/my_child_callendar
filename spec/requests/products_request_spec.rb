# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Products', type: :request do
  let(:event_user) { create(:event_user) }

  describe 'GET /search' do
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

    it 'APIによる通信が成功すること' do
      sign_in event_user
      get search_path, params: { keyword: '赤ちゃん　ミルク' }
      expect(response).to have_http_status(:success)
    end
  end
end
