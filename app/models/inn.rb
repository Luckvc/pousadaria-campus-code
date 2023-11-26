class Inn < ApplicationRecord
  belongs_to :address
  belongs_to :user
  has_many :rooms
  accepts_nested_attributes_for :address

  validates :name, :company_name, :cnpj, :phone, :email, presence: true
end