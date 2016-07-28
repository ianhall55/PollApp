# t.string   "title",      null: false
# t.integer  "author_id",  null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false

class Poll < ActiveRecord::Base

  validates :author_id, presence: true
  validates :title, uniqueness: true, presence: true
  


  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :questions,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Question

end
