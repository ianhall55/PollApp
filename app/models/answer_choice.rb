# t.integer  "question_id", null: false
# t.string   "text",        null: false
# t.datetime "created_at",  null: false
# t.datetime "updated_at",  null: false


class AnswerChoice < ActiveRecord::Base

  validates :question_id, :text, presence: true

  belongs_to :question,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :Question

  has_many :responses,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :Response


end
