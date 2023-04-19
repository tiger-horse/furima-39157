require 'rails_helper'

RSpec.describe HistoryAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @history_address = FactoryBot.build(:history_address, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@history_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @history_address.building = ''
        expect(@history_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @history_address.post_code = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @history_address.post_code = '1234567'
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include('Post code 000-0000ので記入してください')
      end

      it 'prefecture_idが空では登録できない' do
        @history_address.prefecture_id = nil
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idのidが1では登録できない' do
        @history_address.prefecture_id = 1
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include('Prefecture 選択してください')
      end

      it 'municipalityが空だと保存できないこと' do
        @history_address.municipality = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'addressが空だと保存できないこと' do
        @history_address.address = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'telが空だと保存できないこと' do
        @history_address.tel = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Tel can't be blank")
      end

      it 'telが半角のハイフンがあり、正しい形式でないと保存できないこと' do
        @history_address.tel = '123-4567-890'
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include('Tel ハイフンなしの半角数値の10桁or11桁で記入してください')
      end

      it 'telが12桁で正しい形式でないと保存できないこと' do
        @history_address.tel = 101_010_101_010
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include('Tel ハイフンなしの半角数値の10桁or11桁で記入してください')
      end

      it 'telが9桁で正しい形式でないと保存できないこと' do
        @history_address.tel = 123_456_789
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include('Tel ハイフンなしの半角数値の10桁or11桁で記入してください')
      end

      it 'userが紐付いていないと保存できないこと' do
        @history_address.user_id = nil
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @history_address.item_id = nil
        @history_address.valid?

        expect(@history_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では登録できないこと' do
        @history_address.token = nil
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
