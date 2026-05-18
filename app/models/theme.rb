class Theme < ApplicationRecord
  belongs_to :user
  has_many :elements
  has_many :messages, through: :elements

  validates :name, presence: true
  validates :specs, presence: true
end
