class CreateCondoms < ActiveRecord::Migration[5.2]
  def change
    create_table :condoms do |t|
      t.string :name
      t.string :store
      t.string :image
      t.string :type
      t.integer :count
      t.integer :price
      t.string :describe

      t.timestamps
    end
  end
end
