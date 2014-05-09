class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order

      t.string  :num
      t.integer :create_time
      t.integer :pay_time
      t.integer :status
      t.timestamps
    end
  end
   def self.down
    drop_table :orders
  end
end
