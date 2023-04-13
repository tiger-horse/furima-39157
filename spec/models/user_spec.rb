require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "9項目全てが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
     
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      
      it "重複したemailが存在する場合は登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        # binding.pry
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      
      it "emailは@を含まないと登録できない" do
        @user.email = "testmail"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      
      it "passwordが5文字以下では登録できない" do
        @user.password = "1234e"
        @user.password_confirmation = "1234e"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129)
        @user.password_confirmation =  @user.password
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      
      it "passwordが半角数字だけでは登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
      end
      
      it "passwordが半角英字だけでは登録できない" do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
      end
      
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "1abcdef"
        @user.password_confirmation = "abcdef1"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      
      it "last_nameが空では登録できない" do
        @user.last_name = ""
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      
      it "first_nameが空では登録できない" do
        @user.first_name = ""
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      
      it "last_nameがアルファベットでは登録できない" do
        @user.last_name = "yamada"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Last name 全角（漢字・ひらがな・カタカナ）文字を使用してください")
      end
      
      it "first_nameがアルファベットでは登録できない" do
        @user.first_name = "tarou"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("First name 全角（漢字・ひらがな・カタカナ）文字を使用してください")
      end

      it "kana_last_nameが空では登録できない" do
        @user.kana_last_name = ""
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Kana last name can't be blank")
      end
      
      it "kana_first_nameが空では登録できない" do
        @user.kana_first_name = ""
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      
      it "kana_last_nameが漢字では登録できない" do
        @user.kana_last_name = "山田"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Kana last name 全角（カタカナ）を使用してください")
      end
      
      
      it "kana_last_nameがひらがなでは登録できない" do
        @user.kana_last_name = "やまだ"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Kana last name 全角（カタカナ）を使用してください")  
      end
      
      it "kana_first_nameが漢字では登録できない" do
        @user.kana_first_name = "太郎"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Kana first name 全角（カタカナ）を使用してください")
      end
      
      it "kana_first_nameがひらがなでは登録できない" do
        @user.kana_first_name = "たろう"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Kana first name 全角（カタカナ）を使用してください")
      end

      it  "date_of_birthが空では登録できない" do
        @user.date_of_birth = nil
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end      
  
    end
  end
end











