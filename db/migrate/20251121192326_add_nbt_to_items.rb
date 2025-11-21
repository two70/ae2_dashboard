class AddNbtToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :nbt, :json
  end
end
