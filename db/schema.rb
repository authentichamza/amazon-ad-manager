# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_12_102143) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_groups", force: :cascade do |t|
    t.string "name"
    t.decimal "default_bid"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_ad_groups_on_campaign_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.integer "budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.bigint "ad_group_id", null: false
    t.string "text"
    t.decimal "bid"
    t.string "match_type"
    t.integer "impressions"
    t.integer "clicks"
    t.decimal "ctr"
    t.decimal "spend"
    t.decimal "sales"
    t.integer "orders"
    t.integer "units"
    t.decimal "cr"
    t.decimal "acos"
    t.decimal "cpc"
    t.decimal "roas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_group_id"], name: "index_keywords_on_ad_group_id"
  end

  add_foreign_key "keywords", "ad_groups"
end
