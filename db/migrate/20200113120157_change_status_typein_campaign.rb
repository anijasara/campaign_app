class ChangeStatusTypeinCampaign < ActiveRecord::Migration[5.2]
  def change
    change_column :campaigns, :status, :string
  end
end
