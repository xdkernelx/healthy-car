class Maintenance < ApplicationRecord

  has_many :comments, as: :commentable
  belongs_to :car
  belongs_to :shop, optional: true

  validates :title, :description, :mileage, :date_completed, { presence: true }
  validates :mileage, numericality: { greater_than: 0 }
  validate :shop_status

  def shop_status
    if self.shop_id
      begin
        shop = Shop.find(self.shop_id)
      rescue
        errors.add(:shop_id, "shop does not exist.")
      end
    end

  end

end
