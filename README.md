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
| item_name          | string     | null: false |
| content          | text       | null: false |
| category_id     | integer     | null: false |
| condition_id   | integer     | null: false |
| postage_id    | integer     | null: false |
| prefecture_id      |integer      | null: false |
| scheduled_delivery_id | integer     | null: false |
| price               | integer    | null: false | 
| user                     | references | null: false, foreign_key: true |
＊imageはActiveStorageで実装するため含まない

belongs_to :user
has_one :history


## _addressesテーブル
| Column               | Type                 | Options     |
| ------------------   | ------               | ----------- |
| post_code     | string              | null: false |
| prefecture_id | integer            | null: false |
| municipality    | string              | null: false |
| address          | string               | null: false |
| building        | string               |             |
| tel           |  string             | null: false |
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


