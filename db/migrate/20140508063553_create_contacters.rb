class CreateContacters < ActiveRecord::Migration
  def change
    create_table :contacters do |t|
      t.string :contact

      t.timestamps
    end
  end
end
