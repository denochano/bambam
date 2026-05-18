class Element < ApplicationRecord
  belongs_to :theme
  has_many :messages

  validates :name, presence: true
end
