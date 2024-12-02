class AddResponseFormatToStageGateParameter < ActiveRecord::Migration[7.2]
  def change
    add_column :parameter_recommendations, :response_format, :jsonb
  end
end
