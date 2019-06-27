class ChangePostSummaryToLongtext < ActiveRecord::Migration[5.2]
  def change
  	change_column :posts, :summary, :text
  end
end
