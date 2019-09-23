# This migration comes from app_component (originally 20190921144208)
class CreateAppComponentTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :app_component_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
