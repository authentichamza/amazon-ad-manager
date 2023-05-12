class CreateAdGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :ad_groups do |t|
      t.string :name
      t.decimal :default_bid
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
