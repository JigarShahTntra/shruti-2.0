class CreateCriteriaMitigations < ActiveRecord::Migration[7.2]
  def change
    create_table :criteria_mitigations do |t|
      t.string :title
      t.references :criteria, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
