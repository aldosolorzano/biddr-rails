class CreateAuctions < ActiveRecord::Migration[5.0]
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.date :ends_on
      t.integer :reserve_price
      t.integer :bid_price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
