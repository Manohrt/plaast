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

ActiveRecord::Schema.define(version: 20160426110346) do

  create_table "admins", force: :cascade do |t|
    t.string   "order_party"
    t.string   "purchase_party"
    t.string   "chem"
    t.string   "chem_typ"
    t.string   "ra_material"
    t.string   "mouldno"
    t.string   "finishgoods"
    t.string   "mach_use"
    t.string   "reason_idle"
    t.string   "work_nature"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "chemical_types", force: :cascade do |t|
    t.string   "chemical_type_list"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "chemicals", force: :cascade do |t|
    t.string   "chemical_list"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "color_issues", force: :cascade do |t|
    t.string   "color_issue_list"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "costs", force: :cascade do |t|
    t.string   "cost_per_unit"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "finished_goods_names", force: :cascade do |t|
    t.string   "finished_goods_name_list"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "finisheds", force: :cascade do |t|
    t.string   "nett_available"
    t.string   "freight"
    t.string   "overheads"
    t.string   "packing_materials"
    t.string   "spares_used"
    t.string   "spares_cost"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "production_report_id"
    t.integer  "labour_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "deleted_at"
    t.string   "shift"
    t.string   "issue_date"
    t.integer  "order_no"
    t.integer  "issue_slip_no"
  end

  add_index "finisheds", ["labour_id"], name: "index_finisheds_on_labour_id"
  add_index "finisheds", ["production_report_id"], name: "index_finisheds_on_production_report_id"

  create_table "insert_materials", force: :cascade do |t|
    t.string   "insert_material_list"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "ireturns", force: :cascade do |t|
    t.string   "grn_no"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "issue_id"
    t.datetime "deleted_at"
    t.string   "shift"
    t.string   "issue_date"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "order_no"
    t.integer  "issue_slip_no"
  end

  add_index "ireturns", ["issue_id"], name: "index_ireturns_on_issue_id"

  create_table "issues", force: :cascade do |t|
    t.string   "order_date"
    t.string   "rm_qty"
    t.string   "che_qty"
    t.string   "rg_qty"
    t.string   "party"
    t.string   "issue_date"
    t.string   "machine_no"
    t.string   "shift"
    t.string   "chem_qty"
    t.string   "chem_qty_return"
    t.string   "chem_rate"
    t.string   "generated"
    t.string   "lumps"
    t.string   "qty_after_rg"
    t.string   "rm_issues"
    t.string   "rm_consume"
    t.string   "rm_qty_return"
    t.string   "rm_rate"
    t.string   "rg_material_issues"
    t.string   "rg_qty_issued"
    t.string   "rg_qty_return"
    t.string   "rg_consume"
    t.string   "rg_rate"
    t.string   "rm_cost"
    t.string   "che_cost"
    t.string   "rg_cost"
    t.string   "consolidated_qty"
    t.string   "consolidated_cost"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "chemicals_type"
    t.datetime "deleted_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "order_summary_id"
    t.string   "chemicals"
    t.string   "total_kgs"
    t.string   "bush_mat_issues"
    t.string   "bush_qty_issued"
    t.string   "bush_qty_return"
    t.string   "bush_rate"
    t.string   "bush_cost"
    t.string   "insert_material"
    t.string   "bush_qty"
    t.string   "rm_mat_qty"
    t.string   "ferul_mat_issues"
    t.string   "ferul_qty_issued"
    t.string   "ferul_qty_return"
    t.string   "ferul_rate"
    t.string   "ferul_cost"
    t.string   "ferul_qty"
    t.string   "total_iss"
    t.integer  "order_no"
    t.integer  "issue_slip_no"
  end

  add_index "issues", ["deleted_at"], name: "index_issues_on_deleted_at"
  add_index "issues", ["order_summary_id"], name: "index_issues_on_order_summary_id"

  create_table "labours", force: :cascade do |t|
    t.string   "nature"
    t.string   "difference"
    t.string   "rate_per_person"
    t.string   "efficiency"
    t.string   "cost_per_shift"
    t.string   "no_of_hrs_idle"
    t.string   "no_of_mins_idle"
    t.string   "reasons_for_idle"
    t.string   "no_of_cavity"
    t.string   "cycle_time"
    t.string   "no_of_persons"
    t.string   "working_hrs"
    t.string   "supervisor_name"
    t.string   "other_work"
    t.string   "expected_production"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "mould"
    t.datetime "deleted_at"
    t.integer  "issue_id"
    t.integer  "production_report_id"
    t.string   "total_no_of_items_produced"
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "date"
    t.string   "spares_name"
    t.string   "spares_cost"
    t.string   "remarks"
    t.string   "shift"
    t.string   "issue_date"
    t.string   "machine_no"
    t.integer  "order_summary_id"
    t.string   "pro_time"
    t.integer  "order_no"
    t.integer  "issue_slip_no"
  end

  add_index "labours", ["deleted_at"], name: "index_labours_on_deleted_at"
  add_index "labours", ["issue_id"], name: "index_labours_on_issue_id"
  add_index "labours", ["order_summary_id"], name: "index_labours_on_order_summary_id"
  add_index "labours", ["production_report_id"], name: "index_labours_on_production_report_id"

  create_table "machine_maintenances", force: :cascade do |t|
    t.string   "mach_no"
    t.string   "type_of_prob"
    t.string   "spare_name"
    t.string   "spare_cost"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "date"
    t.datetime "deleted_at"
  end

  add_index "machine_maintenances", ["deleted_at"], name: "index_machine_maintenances_on_deleted_at"

  create_table "machine_nos", force: :cascade do |t|
    t.string   "machine_no_list"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "machine_useds", force: :cascade do |t|
    t.string   "machine_used_list"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "mould_nos", force: :cascade do |t|
    t.string   "mould_no_list"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "name_of_supervisors", force: :cascade do |t|
    t.string   "name_of_supervisor_list"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "nature_of_works", force: :cascade do |t|
    t.string   "nature_of_work_list"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "order_summaries", force: :cascade do |t|
    t.string   "order_date"
    t.string   "scheduled_date"
    t.string   "party"
    t.string   "goods_finished"
    t.string   "nos"
    t.string   "ra_material"
    t.string   "rm_qty_per_item"
    t.string   "chemicals"
    t.string   "color_std"
    t.string   "chemical_qty"
    t.string   "total_kgs"
    t.string   "total_rm_kgs"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "deleted_at"
    t.string   "reground_material"
    t.string   "mould_no"
    t.string   "chel"
    t.string   "color_sd"
    t.integer  "order_no"
  end

  create_table "party_orders", force: :cascade do |t|
    t.string   "party_order_list"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "party_purchases", force: :cascade do |t|
    t.string   "party_purchase_list"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "production_reports", force: :cascade do |t|
    t.string   "finished_goods_name"
    t.string   "total_no_of_items_produced"
    t.string   "weight_per_item"
    t.string   "total_weight_consumed"
    t.string   "standard_weight"
    t.string   "no_of_kgs_used_for_production"
    t.string   "variance"
    t.string   "rejected_nos"
    t.string   "rejected_nos_wt_for_re_grounding"
    t.string   "lumps"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "issue_id"
    t.string   "order_date"
    t.string   "shift"
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "date"
    t.string   "party"
    t.string   "consolidated_qty"
    t.string   "selling_price"
    t.string   "profit_loss"
    t.string   "issue_date"
    t.string   "machine_no"
    t.datetime "deleted_at"
    t.string   "consolidated_cost"
    t.string   "realization_in_wt"
    t.string   "power_unit_reading"
    t.string   "power_unit_cost_kg"
    t.string   "power_unit_cost_piece"
    t.string   "cost_per_unit"
    t.string   "realization_in_per"
    t.string   "reason_rejection"
    t.integer  "order_no"
    t.integer  "issue_slip_no"
    t.text     "action_taken"
  end

  add_index "production_reports", ["issue_id"], name: "index_production_reports_on_issue_id"

  create_table "purchases", force: :cascade do |t|
    t.string   "item"
    t.string   "bill_value"
    t.string   "grn_no"
    t.string   "desc"
    t.string   "rate"
    t.string   "date"
    t.string   "debit"
    t.string   "party"
    t.string   "qty_accepted"
    t.string   "reasons"
    t.string   "trading_material"
    t.string   "rejected"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "select_report"
    t.datetime "deleted_at"
    t.string   "qty_received"
    t.string   "created_by"
    t.string   "updated_by"
  end

  add_index "purchases", ["deleted_at"], name: "index_purchases_on_deleted_at"

  create_table "raw_materials", force: :cascade do |t|
    t.string   "raw_material_list"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "reason_for_idle_times", force: :cascade do |t|
    t.string   "reason_for_idle_time_list"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "regrounds", force: :cascade do |t|
    t.string   "reground_list"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "rejection_reasons", force: :cascade do |t|
    t.string   "rejection_reason_list"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "returns", force: :cascade do |t|
    t.string   "grn_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "issue_id"
    t.string   "created_by"
    t.string   "updated_by"
  end

  add_index "returns", ["issue_id"], name: "index_returns_on_issue_id"

  create_table "type_of_chemicals", force: :cascade do |t|
    t.string   "type_of_chemical_list"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "type_of_purchases", force: :cascade do |t|
    t.string   "purchase_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.string   "password_confirmation"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "role"
  end

end
