class User < ApplicationRecord
  has_many :themes
  has_many :elements, through: :themes
  has_many :messages, through: :elements
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
