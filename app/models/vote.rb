class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :user, uniqueness: {scope: :question}
end
