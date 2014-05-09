class CreateScools < ActiveRecord::Migration
  def self.up
    create_table :scools do |t|
      t.string :scool
      t.string :name 
      t.text :descration
      t.string :url
      t.string :profile_image_url
      t.string :location
      t.string :telephone
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :scools
  end
end
