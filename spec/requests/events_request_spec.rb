require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:event_user) { create(:event_user) }
  let(:event) { create(:event) }
  let!(:update_event) { create(:update_event) }
  let(:event_params) { attributes_for(:event) }
  let(:update_event_params) { attributes_for(:update_event) }
  let(:changed_event_params) { attributes_for(:update_event, icon: 'pee.png') }

  describe 'イベントの登録' do
    subject { post events_path, xhr: true, params: { event: event_params } }
    context 'ログインしている場合' do
      before do
        sign_in event_user
      end
      it 'イベントの登録' do
        expect { subject }.to change(Event, :count).by 1
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'イベントの登録できない' do
        expect { subject }.to change(Event, :count).by 0
        expect(response.status).to eq 401
      end
    end
  end

  describe 'イベントの更新' do
    subject { patch event_path(update_event), xhr: true, params: { event: changed_event_params } }
    context 'ログインしている場合' do
      before do
        sign_in event_user
      end
      it 'イベントが更新された' do
        is_expected.to eq 200
        expect(update_event.reload.icon).to eq 'pee.png'
      end
    end

    context 'ログインしていない場合' do
      it 'イベントの更新ができない' do
        is_expected.to eq 401
        expect(update_event.reload.icon).to eq 'milk.png'
      end
    end
  end
end
