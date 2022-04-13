class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :detail
      t.boolean :status, default: false
      t.integer :user_id
      t.float :total, default: 0
      t.integer :progress, default: 0
      t.datetime :start_day
      t.datetime :finish_day
      
      t.timestamps
    end
  end
end
