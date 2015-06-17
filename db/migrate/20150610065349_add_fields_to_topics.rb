class AddFieldsToTopics < ActiveRecord::Migration
  def change
  	  	add_column :topics, :audio, :string
        add_column :topics, :answer, :text
  end
end
