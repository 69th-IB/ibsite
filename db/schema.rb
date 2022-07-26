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

ActiveRecord::Schema[7.0].define(version: 2022_07_12_195951) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "discord_role_members", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "role_id"], name: "index_discord_role_members_on_user_id_and_role_id", unique: true
  end

  create_table "discord_role_permissions", force: :cascade do |t|
    t.integer "role_id", null: false
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id", "key"], name: "index_discord_role_permissions_on_role_id_and_key", unique: true
    t.index ["role_id"], name: "index_discord_role_permissions_on_role_id"
  end

  create_table "discord_roles", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.string "color"
    t.integer "position", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "hidden_for_permissions", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_discord_roles_on_uid", unique: true
  end

  create_table "missions", force: :cascade do |t|
    t.string "title", default: "Operation", null: false
    t.datetime "start"
    t.integer "creator_id", null: false
    t.boolean "draft", default: true, null: false
    t.boolean "public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_missions_on_creator_id"
  end

  create_table "modlist_mods", force: :cascade do |t|
    t.integer "modlist_id", null: false
    t.integer "mod_id", null: false
    t.boolean "optional", default: false
    t.boolean "server_only", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mod_id"], name: "index_modlist_mods_on_mod_id"
    t.index ["modlist_id"], name: "index_modlist_mods_on_modlist_id"
  end

  create_table "modlists", force: :cascade do |t|
    t.string "title"
    t.integer "creator_id"
    t.datetime "published_at"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mods", force: :cascade do |t|
    t.string "title"
    t.integer "workshop_id"
    t.integer "file_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "server_configs", force: :cascade do |t|
    t.string "params"
    t.string "branch"
    t.string "creator_dlc"
    t.integer "maxfps"
    t.integer "headless_clients"
    t.integer "modlist_id", null: false
    t.integer "mission_id", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id"], name: "index_server_configs_on_mission_id"
    t.index ["modlist_id"], name: "index_server_configs_on_modlist_id"
  end

  create_table "slots", force: :cascade do |t|
    t.string "name"
    t.integer "squad_id", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["squad_id"], name: "index_slots_on_squad_id"
    t.index ["user_id"], name: "index_slots_on_user_id"
  end

  create_table "squads", force: :cascade do |t|
    t.string "name"
    t.integer "mission_id", null: false
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["mission_id"], name: "index_squads_on_mission_id"
    t.index ["parent_id"], name: "index_squads_on_parent_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "remember_created_at"
    t.string "discord_uid", null: false
    t.string "discord_name", null: false
    t.string "discord_discriminator", null: false
    t.string "discord_avatar_url"
    t.integer "discord_accent_color"
    t.string "steam_uid"
    t.string "steam_nickname"
    t.string "steam_avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone", default: "UTC", null: false
    t.string "discord_nick"
    t.string "discord_color"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "missions", "users", column: "creator_id"
  add_foreign_key "modlist_mods", "modlists"
  add_foreign_key "modlist_mods", "mods"
  add_foreign_key "server_configs", "missions"
  add_foreign_key "server_configs", "modlists"
  add_foreign_key "slots", "squads"
  add_foreign_key "slots", "users"
  add_foreign_key "squads", "missions"
  add_foreign_key "squads", "squads", column: "parent_id"
end
