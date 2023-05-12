class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.date :start_date
      t.integer :budget
       
      t.timestamps
    end
  end
end
