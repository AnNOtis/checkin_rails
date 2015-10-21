class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :user_agent
      t.string :device_token

      t.timestamps null: false
    end
  end
end
