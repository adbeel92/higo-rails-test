class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :invoices

  validates :email, presence: true,
                    format: { with: Regexp::EMAIL },
                    uniqueness: {
                      case_insensitive: false
                    }
end
