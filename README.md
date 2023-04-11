# テーブル設計
## _usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| kana_last_name     | string | null: false |
| kana_first_name    | string | null: false |
| date_of_birth      | date    | null: false |


has_many :items
has_many :histories




## _itemsテーブル
| Column                    | Type       | Options     |
| ------------------------  | ------     | ----------- |
| item_name(商品名)          | string     | null: false |
| content(商品説明)          | text       | null: false |
| category_id(カテゴリー)     | integer     | null: false |
| condition_id(商品の状態)   | integer     | null: false |
| postage_id(配送料の負担)    | integer     | null: false |
| prefecture_id(地域)       |integer      | null: false |
| scheduled_delivery_id(日数) | integer     | null: false |
| price(価格)               | integer    | null: false | 
| user                     | references | null: false, foreign_key: true |
＊imageはActiveStorageで実装するため含まない

belongs_to :user
has_one :history


## _addressesテーブル
| Column               | Type                 | Options     |
| ------------------   | ------               | ----------- |
| post_code(郵便番号)     | string              | null: false |
| prefecture_id(都道府県) | integer            | null: false |
| municipality(市町村)    | string              | null: false |
| address(番地)          | string               | null: false |
| building(建物名)        | string               |             |
| tel(電話番号)            |  string             | null: false |
| history               | references      | null: false, foreign_key: true |


belongs_to :history

## historiesテーブル
| Column             | Type           | Options     |
| ------------------ | ------       | ----------- |
| user               | references    | null: false, foreign_key: true |
| item               | references    | null: false, foreign_key: true |

belongs_to :item
belongs_to :user
has_one :address


