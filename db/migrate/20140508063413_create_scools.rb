class CreateScools < ActiveRecord::Migration
  
   def self.up
    create_table :scools do |t|
      t.string :scool_id
      t.string :name 
      t.string :url
      t.string :profile_image_url
      t.text :descration , :default =>"抱歉，暂无描述"
      t.string :location
      t.string :telephone
      t.integer :created_at
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :scools
  end
end
