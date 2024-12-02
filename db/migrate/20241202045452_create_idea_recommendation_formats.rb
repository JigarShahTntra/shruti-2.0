class CreateIdeaRecommendationFormats < ActiveRecord::Migration[7.2]
  def change
    create_table :idea_recommendation_formats do |t|
      t.jsonb :body
      t.references :idea_parameter_recommendation_detail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
