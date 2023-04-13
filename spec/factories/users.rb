FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name {"山田"}
    first_name {"太郎"}
    kana_last_name {"ヤマダ"}
    kana_first_name {"タロウ"}
    date_of_birth {Faker::Date.birthday}
  end
end


