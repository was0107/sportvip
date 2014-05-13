class CreateScools < ActiveRecord::Migration
  def self.up
    create_table :scools do |t|
      t.string :name 
      t.string :telephone 
      t.string :url
      t.string :profile_image_url
      t.string :location    
      t.text :description
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :scools
  end
end
