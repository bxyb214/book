class AddCountsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :topics_count, :integer, default: 0
    add_column :users, :comments_count, :integer, default: 0

    User.reset_column_information

    User.find_each do |user|
      User.reset_counters user.id, :topics
      User.reset_counters user.id, :comments
    end
  end
  def down
    remove_column :users, :topics_count
    remove_column :users, :comments_count
  end
end
