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
| kana_first _name    | string | null: false |
| date_of_birth      | datetime | null: false |


has_many :items
has_many :comments


## _itemsテーブル
| Column                    | Type       | Options     |
| ------------------------  | ------     | ----------- |
| item_name(商品名)          | string     | null: false |
| content(商品説明)          | text       | null: false |
| category(カテゴリー)        | string     | null: false |
| item_condition(商品の状態)  | string     | null: false |
| item_postage(配送料の負担)  | string     | null: false |
| item_region(地域)         | string     | null: false |
| item_days(日数)           | string     | null: false |
| price(価格)               | integer    | null: false | 
| user                     | references | null: false, foreign_key: true |
＊imageはActiveStorageで実装するため含まない

belongs_to :user
belongs_to :buyer
has_many :comments


## _buyerテーブル
| Column               | Type       | Options     |
| ------------------   | ------     | ----------- |
| post_code(郵便番号)     | string     | null: false |
| prefectures(都道府県)   | string     | null: false |
| municipality(市町村)    | string     | null: false |
| address(番地)          | string     | null: false |
| building(建物名)        | string     |             |
| tel(電話番号)            | integer     | null: false |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

has_one :item
has_one :user


## _commentsテーブル

| Column           | Type       | Options                        |
| -------          | ---------- | ------------------------------ |
| comment(コメント) | string     | null: false,                   |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

belongs_to :user
belongs_to :item
