class Element < ApplicationRecord
  belongs_to :theme
  has_many :messages, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :messages, allow_destroy: true
end
