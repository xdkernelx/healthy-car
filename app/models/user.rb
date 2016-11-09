class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :lockable, :trackable, :validatable

  has_many :cars
  has_many :shops
  has_many :tickets
  has_many :issues, through: :cars
  has_many :repairs, through: :issues
  has_many :maintenances, through: :cars

  validates :first_name, :last_name, { presence: true }
  validates :zip_code, format: { with: /\A[0-9]{5}\z/ }, allow_blank: true
  validates :phone, format: { with: /\A[0-9]{10}\z/ }, allow_blank: true

end
