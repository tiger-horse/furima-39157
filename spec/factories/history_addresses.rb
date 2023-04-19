FactoryBot.define do
  factory :history_address do
    post_code { '123-1234' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality { Faker::Address.city }
    address { Faker::Address.city_prefix }
    building { Faker::Address.city_suffix }
    tel { 1_234_567_890 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
