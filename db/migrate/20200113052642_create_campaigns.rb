class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :external_reference
      t.text :description
      t.boolean :status

      t.timestamps
    end
  end
end
