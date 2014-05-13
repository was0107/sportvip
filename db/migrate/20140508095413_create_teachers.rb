class CreateTeachers < ActiveRecord::Migration
  def self.up
    create_table :teachers do |t|
      t.string :name 
      t.text :description
      t.string :profile_image_url
      t.string :telephone
      t.timestamps
    end
  end
   def self.down
    drop_table :teachers
  end
end
