class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
 	    t.string :name 
      t.string :telephone
      t.integer :gender
      t.integer :parent
      t.integer :is_default_contact
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
