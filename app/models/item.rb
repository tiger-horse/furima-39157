class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :item_name, length: { maximum: 41 }
    validates :content,   length: { maximum: 1001 }
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image

    with_options numericality: { other_than: 1, message: '選択してください' } do
      validates :category_id
      validates :condition_id
      validates :postage_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
  end
end
