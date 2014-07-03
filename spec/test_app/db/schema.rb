# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140703104122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "tethys_aggregates", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "aggregate_type"
    t.integer  "version",        default: -1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tethys_event_sets", force: true do |t|
    t.uuid     "aggregate_id"
    t.integer  "version"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tethys_snapshots", force: true do |t|
    t.integer  "aggregate_id"
    t.text     "data"
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tethys_snapshots", ["aggregate_id"], name: "index_tethys_snapshots_on_aggregate_id", using: :btree

end
