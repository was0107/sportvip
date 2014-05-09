class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :student
 	  t.string :name 
      t.string :telephone
      t.integer :parent
      t.integer :is_default_contact
      t.integer :gender
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
