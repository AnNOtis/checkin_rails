class CreateFollowerFollowingShips < ActiveRecord::Migration
  def change
    create_table :follower_following_ships do |t|
      t.integer :follower_id, index: true
      t.integer :following_id, index: true

      t.timestamps null: false
    end

    add_foreign_key :follower_following_ships, :users, column: :following_id
    add_foreign_key :follower_following_ships, :users, column: :follower_id
    add_index :follower_following_ships, [:follower_id, :following_id], unique: true
  end
end
