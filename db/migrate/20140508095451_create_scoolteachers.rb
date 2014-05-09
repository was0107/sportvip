class CreateScoolteachers < ActiveRecord::Migration
  def self.up
    create_table :scoolteachers do |t|

      t.timestamps
    end
  end
   def self.down
    drop_table :scoolteachers
  end
end
