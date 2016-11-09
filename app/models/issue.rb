class Issue < ApplicationRecord

  belongs_to :car
  has_many :repairs, as: :repairable
  has_many :permissions

  validates :title, :description, { presence: true }
  validates :urgency, numericality: { greater_than: 0, less_than_or_equal_to: 5 }

  def recent_repairs(limit)
    self.repairs.sort_by{|repair| repair.date_completed}.reverse!.take(limit)
  end

end
