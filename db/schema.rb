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

ActiveRecord::Schema.define(version: 20190820152821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "app_memberships", force: :cascade do |t|
    t.integer "company_id"
    t.integer "app_id"
    t.integer "package_id"
    t.boolean "active", default: true
    t.datetime "canceled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_app_memberships_on_app_id"
    t.index ["company_id"], name: "index_app_memberships_on_company_id"
    t.index ["package_id"], name: "index_app_memberships_on_package_id"
  end

  create_table "app_modules", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.integer "app_id"
    t.string "name"
    t.string "machine_name"
    t.text "description"
    t.integer "status", default: 0
    t.index ["app_id"], name: "index_app_modules_on_app_id"
    t.index ["machine_name"], name: "index_app_modules_on_machine_name"
    t.index ["uuid"], name: "index_app_modules_on_uuid"
  end

  create_table "apps", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.integer "status", default: 0
    t.string "version"
    t.string "name"
    t.string "machine_name"
    t.index ["machine_name"], name: "index_apps_on_machine_name"
    t.index ["uuid"], name: "index_apps_on_uuid"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "company_id"
    t.integer "app_id"
    t.string "type"
    t.integer "status", default: 0
    t.string "name"
    t.boolean "editable", default: false
    t.boolean "default", default: false
    t.index ["app_id"], name: "index_categories_on_app_id"
    t.index ["company_id"], name: "index_categories_on_company_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "author_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "label"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
  end

  create_table "companies", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.integer "status", default: 0
    t.string "name"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_companies_on_uuid"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 0
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_departments_on_company_id"
  end

  create_table "invoicing", force: :cascade do |t|
    t.datetime "date"
    t.string "qb_number"
    t.string "client_name"
    t.integer "ticket_number"
    t.integer "client_id"
    t.integer "user_id"
    t.integer "status_id"
    t.integer "category_id"
    t.text "note"
    t.text "admin_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.integer "loggable_id"
    t.string "loggable_type"
    t.integer "action", default: 0
    t.string "device_name"
    t.string "browser_name"
    t.string "os_name"
    t.string "ip_address"
    t.string "user_agent"
    t.boolean "mobile", default: false
    t.boolean "tablet", default: false
    t.boolean "robot", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "author_id"
    t.index ["author_id"], name: "index_logs_on_author_id"
    t.index ["loggable_id"], name: "index_logs_on_loggable_id"
    t.index ["loggable_type"], name: "index_logs_on_loggable_type"
    t.index ["uuid"], name: "index_logs_on_uuid"
  end

  create_table "module_memberships", force: :cascade do |t|
    t.integer "company_id"
    t.integer "module_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "module_id"], name: "copmany_module_index", unique: true
  end

  create_table "packages", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.integer "app_id"
    t.string "name"
    t.string "machine_name"
    t.integer "max_users"
    t.boolean "active", default: true
    t.index ["app_id"], name: "index_packages_on_app_id"
    t.index ["machine_name"], name: "index_packages_on_machine_name"
    t.index ["uuid"], name: "index_packages_on_uuid"
  end

  create_table "policies", force: :cascade do |t|
    t.integer "company_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_policies_on_company_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "encrypted_ssn"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "title"
    t.date "starting_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "pto_availabilities", force: :cascade do |t|
    t.integer "user_id"
    t.integer "author_id"
    t.integer "category_id"
    t.integer "year"
    t.float "total", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_pto_availabilities_on_author_id"
    t.index ["category_id"], name: "index_pto_availabilities_on_category_id"
    t.index ["user_id"], name: "index_pto_availabilities_on_user_id"
  end

  create_table "ptos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.integer "status", default: 0
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "approved_at"
    t.datetime "rejected_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_ptos_on_category_id"
    t.index ["user_id"], name: "index_ptos_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "app_id"
    t.string "name"
    t.string "machine_name"
    t.index ["app_id"], name: "index_roles_on_app_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "user_id"
    t.integer "day"
    t.time "start_time"
    t.integer "work_length"
    t.integer "break_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "day"], name: "index_schedules_on_user_id_and_day", unique: true
  end

  create_table "time_logs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.text "note"
    t.boolean "deleted", default: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "custom", default: false
    t.datetime "actual_started_at"
    t.datetime "actual_stopped_at"
    t.index ["category_id"], name: "index_time_logs_on_category_id"
    t.index ["user_id"], name: "index_time_logs_on_user_id"
  end

  create_table "timesheets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "week"
    t.integer "year"
    t.integer "status", default: 0
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "company_id"
    t.integer "app_id"
    t.integer "role_id"
    t.string "invitation_email"
    t.string "invitation_token"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_expires_at"
    t.datetime "invitation_accepted_at"
    t.json "permissions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitation_token"], name: "index_user_memberships_on_invitation_token"
    t.index ["role_id"], name: "index_user_memberships_on_role_id"
    t.index ["user_id", "company_id", "app_id"], name: "user_app_index", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "email"
    t.integer "status", default: 0
    t.integer "company_id"
    t.string "locale"
    t.string "timezone"
    t.boolean "master", default: false
    t.boolean "admin", default: false
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "policy_accepted_at"
    t.boolean "allow_password_change", default: false, null: false
    t.boolean "deactivated"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["uuid"], name: "index_users_on_uuid"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
