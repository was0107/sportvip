class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :course_id
      t.string :name 
      t.text :descration , :default =>"抱歉，暂无描述"
      t.integer :min_month , :default =>"0"
      t.integer :max_month , :default =>"0"
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
