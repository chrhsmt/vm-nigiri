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

ActiveRecord::Schema.define(version: 20150203111017) do

  create_table "instances", force: :cascade do |t|
    t.string   "name"
    t.integer  "disk_size"
    t.integer  "memory"
    t.string   "ip"
    t.string   "mac"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "machine_id"
    t.integer  "telnet_port"
    t.integer  "key_id"
  end

  add_index "instances", ["ip"], name: "index_instances_on_ip"
  add_index "instances", ["name"], name: "index_instances_on_name"

  create_table "keys", force: :cascade do |t|
    t.string   "name"
    t.string   "public_key"
    t.string   "private_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "instance_id"
  end

  add_index "keys", ["name"], name: "index_keys_on_name"

  create_table "machines", force: :cascade do |t|
    t.string   "name"
    t.integer  "disk_size"
    t.integer  "memory"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_range"
  end

end
