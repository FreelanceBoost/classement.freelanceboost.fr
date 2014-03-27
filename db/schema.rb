ActiveRecord::Schema.define(version: 20140327133154) do

  create_table "rockstars", force: true do |t|
    t.string   "pseudo"
    t.text     "desc"
    t.text     "url_img"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
