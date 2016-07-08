class Answer < ActiveRecord::Base
  belongs_to :question

  validates :body, presence: true, uniqueness: {scope: :question_id}

  def full_name
    "#{first_name} #{last_name}"
  end
end
