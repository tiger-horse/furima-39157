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
        expect(@history_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @history_address.post_code = '1234567'
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("郵便番号を000-0000ので記入してください")
      end

      it 'prefecture_idが空では登録できない' do
        @history_address.prefecture_id = nil
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("都道府県を入力してください")
      end

      it 'prefecture_idのidが1では登録できない' do
        @history_address.prefecture_id = 1
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'municipalityが空だと保存できないこと' do
        @history_address.municipality = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'addressが空だと保存できないこと' do
        @history_address.address = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'telが空だと保存できないこと' do
        @history_address.tel = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'telが半角のハイフンがあり、正しい形式でないと保存できないこと' do
        @history_address.tel = '123-4567-890'
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("電話番号をハイフンなしの半角数値の10桁or11桁で記入してください")
      end

      it 'telが12桁で正しい形式でないと保存できないこと' do
        @history_address.tel = 101_010_101_010
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("電話番号をハイフンなしの半角数値の10桁or11桁で記入してください")
      end

      it 'telが9桁で正しい形式でないと保存できないこと' do
        @history_address.tel = 123_456_789
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("電話番号をハイフンなしの半角数値の10桁or11桁で記入してください")
      end

      it 'userが紐付いていないと保存できないこと' do
        @history_address.user_id = nil
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @history_address.item_id = nil
        @history_address.valid?

        expect(@history_address.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenが空では登録できないこと' do
        @history_address.token = nil
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Tokenを入力してください")
      end
    end
  end
end
