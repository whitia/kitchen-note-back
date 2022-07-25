class Recipe < ApplicationRecord
  has_and_belongs_to_many :ingredients

  validates :title, presence: true
  validates :uuid, presence: true, uniqueness: true
  validates :external_title, presence: true
  validates :external_url, presence: true, uniqueness: true
end
