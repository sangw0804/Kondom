class ChangeScoreToBeFloatInCondoms < ActiveRecord::Migration[5.2]
  def change
    change_column :condoms, :score, :decimal
  end
end
