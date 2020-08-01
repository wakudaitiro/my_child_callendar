require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "Products", type: :request do
  let(:event_user) { create(:event_user) }
  let(:response_body) { create(:response_body) }
  let(:search_params) { { keyword: '赤ちゃん　ミルク' } }

  describe "GET /search" do
    before do
      WebMock.enable!
      stub_request(
        :get, "https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?affiliateId=&applicationId=#{ENV['Rakuten_API_KEY']}&formatVersion=2&keyword=%E8%B5%A4%E3%81%A1%E3%82%83%E3%82%93%20%E3%83%9F%E3%83%AB%E3%82%AF"
      ).to_return(
      body:
      '{
        "Items": [{
                    "mediumImageUrls": [
                        {
                            "imageUrl": "https://thumbnail.image.rakuten.co.jp/@0_mall/ailovegiftbaby/cabinet/sale-babycar/combi/55-015-12-10-0.jpg?_ex=128x128"
                        },
                        {
                            "imageUrl": "https://thumbnail.image.rakuten.co.jp/@0_mall/ailovegiftbaby/cabinet/sale-babycar/combi/55-015-12-10-0y.jpg?_ex=128x128"
                        },
                        {
                            "imageUrl": "https://thumbnail.image.rakuten.co.jp/@0_mall/ailovegiftbaby/cabinet/sale-babycar/combi/55-015-12-10-10.jpg?_ex=128x128"
                        }
                    ],
                    "itemName": "A型ベビーカー 両対面 ハイシート コンビ ホワイトレーベル スゴカル Switch plus エッグショック earth XL オーシャンブルー BL 175593 / ベビーカー Combi ホワイトレーベル【1ヶ月〜36ヶ月頃】【正規販売店】コンビ株式会社より直接仕入れています。",
                    "itemPrice": 69300,
                    "itemUrl": "https://item.rakuten.co.jp/ailovegiftbaby/55-015-12-10/"
                },
                {
                    "mediumImageUrls": [
                        {
                            "imageUrl": "https://thumbnail.image.rakuten.co.jp/@0_mall/toysrus/cabinet/goods/91/210988300all.jpg?_ex=128x128"
                        }
                    ],
                    "itemName": "和光堂 ベビーの時間 ほうじ茶 500ml 【1ヶ月〜】",
                    "itemPrice": 109,
                    "itemUrl": "https://item.rakuten.co.jp/toysrus/210988300/"
                },
                {
                    "mediumImageUrls": [
                        {
                            "imageUrl": "https://thumbnail.image.rakuten.co.jp/@0_mall/freestylezero/cabinet/mem_item/imgrc0077131884.jpg?_ex=128x128"
                        },
                        {
                            "imageUrl": "https://thumbnail.image.rakuten.co.jp/@0_mall/freestylezero/cabinet/mem_item/imgrc0077128536.jpg?_ex=128x128"
                        },
                        {
                            "imageUrl": "https://thumbnail.image.rakuten.co.jp/@0_mall/freestylezero/cabinet/mem_item/imgrc0077128665.jpg?_ex=128x128"
                        }
                    ],
                    "itemName": "【レンタル】抱っこ紐 レンタル 1ヶ月 新生児 赤ちゃん ベビービョルン おんぶ メッシュ ベビー用品 ベビースリング ベビーレンタル 人気 乳児 幼児 子供 おすすめ レンタルベビー 0歳 1歳から 借りる 試す",
                    "itemPrice": 3300,
                    "itemUrl": "https://item.rakuten.co.jp/freestylezero/10000270/"
                }
        ]
    }',
        status: 200,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    it "returns http success" do
      sign_in event_user
      get search_path, params: {keyword: '赤ちゃん　ミルク' }
      expect(response).to have_http_status(:success)
    end
  end
end
