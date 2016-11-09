class Shop < ApplicationRecord

  has_many :comments, as: :commentable
  has_many :maintenances
  has_many :repairs
  belongs_to :mechanic, class_name: "User"

  validates :name, :address, :city, :state, :zip_code, { presence: true }
  validates :state, format: { with: /\A[A-Z]{2}\z/ }
  validates :zip_code, format: { with: /\A[0-9]{5}\z/ }
  validates :phone, format: { with: /\A[0-9]{10}\z/ }, allow_blank: true
  validate :mechanic_status

  def mechanic_status
    begin
      user = User.find(self.mechanic_id)
    rescue
      errors.add(:mechanic_id, "mechanic does not exist.")
    else
      user = User.find(self.mechanic_id)
      if (!user.mech_status)
        errors.add(:mechanic_id, "id must belong to a mechanic user.")
      end
    end

  end

end
