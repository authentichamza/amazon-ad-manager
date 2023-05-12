class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.references :ad_group, null: false, foreign_key: true
      t.string :text
      t.decimal :bid
      t.string :match_type
      t.integer :impressions
      t.integer :clicks
      t.decimal :ctr
      t.decimal :spend
      t.decimal :sales
      t.integer :orders
      t.integer :units
      t.decimal :cr
      t.decimal :acos
      t.decimal :cpc
      t.decimal :roas

      t.timestamps
    end
  end
end
