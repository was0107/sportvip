class CreateScoolcourses < ActiveRecord::Migration
  def self.up
    create_table :scoolcourses do |t|

      t.timestamps
    end
  end

   def self.down
    drop_table :scoolteachers
  end
end
