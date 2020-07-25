RSpec.describe 'POST /sessions', type: :request do
  describe 'user1で' do
    let (:req_params) { { session_form: { email: email1 } } }
    let (:email1) { 'a@a' }
    it 'ログインに成功すること' do
      post "/users/sign_in", params: req_params
      expect(response).to redirect_to calendar_path
    end 
  end
  
  # context '全てのパラメータが揃っている場合' do
  #   it '200 OKを返す'
  #   it '成功時のJSONレスポンスを返す'
  #   it 'ユーザを登録する'
  # end

  # context 'emailパラメータが不足している場合' do
  #   it '400 Bad Requestを返す'
  #   it 'パラメータ不正のJSONレスポンスを返す'
  #   it 'ユーザを登録しない'
  # end

  # context 'emailが既に登録されている場合' do
  #   it '400 Bad Requestを返す'
  #   it 'email重複エラーのJSONレスポンスを返す'
  #   it 'ユーザを登録しない'
  # end

  # context '管理者アカウント未ログインの場合' do
  #   it '401 Unauthorizedを返す'
  #   it 'ユーザを登録しない'
  # end
end