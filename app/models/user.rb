class User < ApplicationRecord
  validates :account, presence: true
  validates :password, presence: true, on: :create
  has_secure_password validations: true
end