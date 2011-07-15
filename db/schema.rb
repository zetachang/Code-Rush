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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110713074839) do

  create_table "assign_items", :force => true do |t|
    t.string   "assign_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assign_id"
    t.string   "title"
    t.text     "options"
    t.text     "description"
    t.string   "ojtype"
    t.string   "number"
  end

  create_table "assigned_ships", :force => true do |t|
    t.integer  "assignment_id"
    t.integer  "oier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.datetime "due_time"
    t.string   "setter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "ISBN"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bookshelf_id"
  end

  create_table "bookshelves", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "codes", :force => true do |t|
    t.string   "title"
    t.string   "creator"
    t.text     "source"
    t.text     "description"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.string   "anchor"
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "oiers", :force => true do |t|
    t.string   "name"
    t.integer  "grade"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "ojees", :force => true do |t|
    t.string   "ojtype"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "oier_id"
    t.string   "type"
    t.string   "problems_solved"
    t.integer  "userid"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "topic"
    t.text     "body"
    t.text     "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tutorials", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assign_item_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
