class Category < ActiveRecord::Base
  has_many :questions, dependent: :nullify
end
