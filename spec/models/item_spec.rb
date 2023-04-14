require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "9項目が存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "item_nameが空では登録できない" do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it "item_nameが41文字以上では登録できない" do
        @item.item_name = Faker::Lorem.paragraph(sentence_count: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name is too long (maximum is 41 characters)")
      end
      it "contentが空では登録できない" do
        @item.content = ""
        @item.valid?   
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      
      it 'contentが1001文字以上では登録できない' do
        @item.content = Faker::Lorem.paragraph(sentence_count: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include("Content is too long (maximum is 1001 characters)")
      end
      
      it 'category_idが空では登録できない' do
        @item.category_id = nil
        @item.valid? 
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      
      it 'category_idのidが1では登録できない' do
        @item.category_id = 1
        @item.valid?   
        expect(@item.errors.full_messages).to include("Category 選択してください")
      end
      
      it 'condition_idが空では登録できない' do
        @item.condition_id = nil
        @item.valid? 
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      
      it 'condition_idのidが1では登録できない' do
        @item.condition_id = 1
        @item.valid?   
        expect(@item.errors.full_messages).to include("Condition 選択してください")
      end
      
      it 'postage_idが空では登録できない' do
        @item.postage_id = nil
        @item.valid? 
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      
      it 'postage_idのidが1では登録できない' do
        @item.postage_id = 1
        @item.valid?   
        expect(@item.errors.full_messages).to include("Postage 選択してください")
      end

      it 'prefecture_idが空では登録できない' do
        @item.prefecture_id = nil
        @item.valid? 
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      
      it 'prefecture_idのidが1では登録できない' do
        @item.prefecture_id = 1
        @item.valid?   
        expect(@item.errors.full_messages).to include("Prefecture 選択してください")
      end
      
      it 'scheduled_delivery_idが空では登録できない' do
        @item.scheduled_delivery_id = nil
        @item.valid? 
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end
      
      it 'scheduled_delivery_idのidが1では登録できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?   
        expect(@item.errors.full_messages).to include("Scheduled delivery 選択してください")
      end
      it 'priceが空では登録できない' do
        @item.price = nil
        @item.valid?   
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      
      it 'priceが299円以下では登録できない' do
        @item.price = 299
        @item.valid?   
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが10000000円以上では登録できない' do
        @item.price = 10000000
        @item.valid?   
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?   
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      
    end
  end
end
