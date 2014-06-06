class CreateNodeFeeds < ActiveRecord::Migration
  def change
    create_table :node_feeds do |t|

      t.timestamps
    end
  end
end
