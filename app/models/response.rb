
# t.integer  "user_id",    null: false
# t.integer  "answer_id",  null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false

class Response < ActiveRecord::Base

  validates :user_id, :answer_id, presence: true
  validate :respondent_already_answered?
  validate :respond_to_own_poll?

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question


  def respond_to_own_poll?
    # whether the poll's author is the same as the respondent_id.
    if self.answer_choice.question.poll.author_id == self.user_id
      errors[:user] << "cannot respond to own poll!"
    end

  end

    # This is a predicate method that checks to see if any sibling exists?
    # with the same respondent_id.

  def respondent_already_answered?
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:user] << "already answered this question"
    end
  end

  def sibling_responses
    question.responses.where.not(id: self.id)
  end


end
