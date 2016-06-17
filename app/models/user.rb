class User < ActiveRecord::Base
  # has_secure_password will give us functionalities needed for user authentication:
  # 1- It will add attribute accessors: password, password_confirmation.
  # 2- It will add validation for password presence and length of password (4..72).
  # 3- If password_confirmation is set, it will validate that it's the same as password.
  # 4- It will add handy methods for us to automatically hash the password to the password_digest field and compare a given password.
  has_secure_password

  has_many :questions, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}"
  end
end
