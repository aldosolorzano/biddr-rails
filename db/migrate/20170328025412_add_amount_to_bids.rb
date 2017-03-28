class AddAmountToBids < ActiveRecord::Migration[5.0]
  def change
    add_column :bids, :amount, :integer
  end
