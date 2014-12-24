class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :usuario, index: true
      t.references :friend, index: true

      t.timestamps
    end
  end
end
