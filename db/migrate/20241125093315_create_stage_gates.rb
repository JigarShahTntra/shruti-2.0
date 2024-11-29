class CreateStageGates < ActiveRecord::Migration[7.2]
  def change
    create_table :stage_gates do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
