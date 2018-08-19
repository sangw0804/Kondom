class ChangeTypeToConType < ActiveRecord::Migration[5.2]
  def change
    rename_column :condoms, :type, :conType
  end
end
