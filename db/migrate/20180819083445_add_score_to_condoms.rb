class AddScoreToCondoms < ActiveRecord::Migration[5.2]
  def change
    add_column :condoms, :score, :integer
  end
end
