class HistoryAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :address, :building, :tel, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: '000-0000ので記入してください' }
    validates :prefecture_id, presence: true, numericality: { other_than: 1, message: '選択してください' }
    validates :municipality
    validates :address
    validates :tel, format: { with: /\A\d{10,11}\z/, message: 'ハイフンなしの半角数値の10桁or11桁で記入してください' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    history = History.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, address: address,
                   building: building, tel: tel, history_id: history.id)
  end
end
