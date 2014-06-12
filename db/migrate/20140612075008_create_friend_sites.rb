class CreateFriendSites < ActiveRecord::Migration
  def change
    create_table :friend_sites do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
