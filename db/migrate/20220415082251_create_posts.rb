class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.decimal :latitude,  precision: 11, scale: 8
      t.decimal :longitude, precision: 11, scale: 8

      t.timestamps
    end
  end
end
