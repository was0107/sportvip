class CreateTeachers < ActiveRecord::Migration

  def self.up
    create_table :teachers do |t|
      t.string :teacher
      t.string :teacher_id
      t.string :name 
      t.string :profile_image_url
      t.text :descration , :default =>"抱歉，暂无描述"

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
