class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :photo
      t.text :comment

      t.timestamps null: false
    end
  end
end
