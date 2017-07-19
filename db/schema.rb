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

ActiveRecord::Schema.define(version: 20170719191019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_users", force: :cascade do |t|
    t.string   "colaborador"
    t.string   "departamento"
    t.string   "user_ad"
    t.string   "senha"
    t.string   "ip"
    t.text     "pastas"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cad_emails", force: :cascade do |t|
    t.string   "email"
    t.string   "senha_email"
    t.string   "skype"
    t.string   "senha_skype"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "callcenters", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "employee"
    t.text     "problem"
    t.text     "solution"
    t.date     "date_finish"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "department"
    t.string   "status"
  end

  add_index "callcenters", ["client_id"], name: "index_callcenters_on_client_id", using: :btree

  create_table "cidades", force: :cascade do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cidades", ["estado_id"], name: "index_cidades_on_estado_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "cnpj"
    t.string   "cellphone"
    t.string   "email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "status"
    t.string   "description"
    t.decimal  "value"
    t.date     "due_date"
    t.string   "obs"
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.string   "cidade_id"
    t.string   "estado_id"
  end

  create_table "dns_servers", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "dns"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dns_servers", ["client_id"], name: "index_dns_servers_on_client_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.string   "owner"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "estados", force: :cascade do |t|
    t.string   "sigla"
    t.string   "nome"
    t.integer  "capital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados", ["capital_id"], name: "index_estados_on_capital_id", using: :btree

  create_table "extra_sales", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "product"
    t.decimal  "value"
    t.date     "due_date"
    t.text     "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "extra_sales", ["client_id"], name: "index_extra_sales_on_client_id", using: :btree

  create_table "heritages", force: :cascade do |t|
    t.string   "description"
    t.string   "type_contract"
    t.integer  "client_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "heritages", ["client_id"], name: "index_heritages_on_client_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "type_invoice"
    t.integer  "client_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "status"
    t.string   "form_receipt"
    t.integer  "installments"
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "qnt"
    t.decimal  "total_value"
    t.integer  "product_id"
    t.integer  "invoice_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["invoice_id"], name: "index_items_on_invoice_id", using: :btree
  add_index "items", ["product_id"], name: "index_items_on_product_id", using: :btree

  create_table "licencas", force: :cascade do |t|
    t.string   "produto"
    t.string   "serial"
    t.integer  "patrimonio_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "descricao"
    t.string   "status"
  end

  add_index "licencas", ["patrimonio_id"], name: "index_licencas_on_patrimonio_id", using: :btree

  create_table "licences", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "serial_bios"
    t.string   "type_licence"
    t.decimal  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "licences", ["client_id"], name: "index_licences_on_client_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthly_accounts", force: :cascade do |t|
    t.date     "due_date"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "value_doc"
  end

  create_table "patrimonios", force: :cascade do |t|
    t.string   "numero_patrimonio"
    t.string   "descricao"
    t.integer  "ad_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "patrimonios", ["ad_user_id"], name: "index_patrimonios_on_ad_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "doc_number"
    t.string   "description"
    t.date     "due_date"
    t.date     "payment_date"
    t.integer  "installments"
    t.decimal  "value_doc"
    t.integer  "supplier_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "type_doc"
    t.string   "status"
  end

  add_index "payments", ["supplier_id"], name: "index_payments_on_supplier_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "qnt"
    t.decimal  "cost_value"
    t.decimal  "cost_sale"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "check_stock"
  end

  add_index "products", ["supplier_id"], name: "index_products_on_supplier_id", using: :btree

  create_table "receipts", force: :cascade do |t|
    t.string   "doc_number"
    t.string   "type_doc"
    t.string   "discription"
    t.date     "due_date"
    t.date     "receipt_date"
    t.integer  "installments"
    t.decimal  "value_doc"
    t.integer  "client_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "status"
    t.integer  "invoice_id"
    t.string   "form_receipt"
  end

  add_index "receipts", ["client_id"], name: "index_receipts_on_client_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "cellphone"
    t.string   "cpf_cnpj"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "cidade_id"
    t.string   "estado_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "type_access"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "ccli"
    t.boolean  "cforn"
    t.boolean  "cpat"
    t.boolean  "cprod"
    t.boolean  "cservidor"
    t.boolean  "cuser"
    t.boolean  "mos"
    t.boolean  "fpag"
    t.boolean  "frec"
    t.boolean  "rcli"
    t.boolean  "rforn"
    t.boolean  "rpat"
    t.boolean  "rprod"
    t.boolean  "rpag"
    t.boolean  "rrec"
    t.boolean  "mupload"
    t.boolean  "clic"
    t.boolean  "ccall"
    t.boolean  "rcall"
    t.boolean  "mpainel_servproject"
    t.boolean  "cextra_sale"
    t.boolean  "fgeral"
    t.boolean  "cmon"
  end

  add_foreign_key "callcenters", "clients"
  add_foreign_key "dns_servers", "clients"
  add_foreign_key "extra_sales", "clients"
  add_foreign_key "heritages", "clients"
  add_foreign_key "invoices", "clients"
  add_foreign_key "items", "invoices"
  add_foreign_key "items", "products"
  add_foreign_key "licencas", "patrimonios"
  add_foreign_key "licences", "clients"
  add_foreign_key "patrimonios", "ad_users"
  add_foreign_key "payments", "suppliers"
  add_foreign_key "products", "suppliers"
  add_foreign_key "receipts", "clients"
end
