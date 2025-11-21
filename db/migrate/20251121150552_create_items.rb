class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :display_name
      t.integer :amount

      t.timestamps
    end
  end
end
