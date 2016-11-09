require 'securerandom'

class Car < ApplicationRecord

  has_many :issues
  has_many :issue_repairs, through: :issues, source: :repairs
  has_many :ticket_repairs, through: :tickets, source: :repairs
  has_many :maintenances
  has_many :permissions
  has_many :tickets
  belongs_to :user

  has_attached_file :image, styles: {large: "600x600>", medium: "300x300>", thumb: "150x150#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :mileage, { presence: true }
  validates :mileage, numericality: { greater_than: 0 }
  validates :vin, format: { with: /\A[a-zA-Z0-9]{17}\z/ }, allow_blank: true


  def repairs
    self.issue_repairs + self.ticket_repairs
  end

  def recent_repairs(limit)
    repairs.sort_by{|repair| repair.date_completed}.reverse!.take(limit)
  end

  def recent_maintenances(limit)
    self.maintenances.sort_by{|maintenance| maintenance.date_completed}.reverse!.take(limit)
  end

  def recent_issues(limit)
    self.issues.sort_by{|issue| issue.updated_at}.reverse!.take(limit)
  end

  def oil_change?
    max_value = 5000
    maintenances_array = recent_maintenances(self.maintenances.length).select { |maintenance| maintenance.title == "oil change" }
    if maintenances_array.length < 2
      return nil
    else
      difference = maintenances_array[0].mileage - maintenances_array[1].mileage
      if difference < 0
        return nil
      # TODO Make it dynamic to the car.range if supplied
      elsif difference >= max_value
        return max_value
      else
        return difference
      end
      return nil
    end
  end

end
