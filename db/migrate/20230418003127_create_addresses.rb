class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :post_code,           null: false
      t.integer :prefecture_id,           null: false
      t.string :municipality,           null: false
      t.string :address,           null: false
      t.string :building          
      t.string :tel,           null: false
      t.references :history, null: false, foreign_key: true
      t.timestamps
    end
  end
end


