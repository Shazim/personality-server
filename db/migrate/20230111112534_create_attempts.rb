class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.references :user
      t.json :answers, default: {}
      t.float :total_points
      t.float :points
      t.float :percentage
      t.timestamps
    end
  end
end
