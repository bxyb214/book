class AddImpressionsCountToTopics < ActiveRecord::Migration
  def change
  	  	add_column :topics, :impressions_count, :integer, default: 0
  end
end
