# t.string   "text",       null: false
# t.integer  "poll_id",    null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false


class Question < ActiveRecord::Base

  validates :poll_id, :text, presence: true


  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses


  def results

    answers = self.answer_choices
      .select("answer_choices.text, COUNT(*)")
      .joins(:responses)
      .where("answer_choices.question_id = ?", self.id)
      .group("answer_choices.id")

    result = {}
    answers.each do |choice|
      result[choice.text] = choice.count
    end
    result

  end

  def results2
    #returns choices -> counts
    results = Hash.new(0)

    answers = answer_choices.includes(:responses)

    answers.each do |choice|
      results[choice.text] = choice.responses.length

    end

    results

  end


end
