class CreateIdeaParameterRecommendationDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :idea_parameter_recommendation_details do |t|
      t.references :idea_parameter_detail, null: false, foreign_key: true
      t.references :parameter_recommendation, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
