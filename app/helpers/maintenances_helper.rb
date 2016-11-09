module MaintenancesHelper
	def owner?(car)
		if car.user == current_user
			true
		else
			false
		end
	end

	def update_mileage(car, mileage)
		if car.mileage <= mileage
			car.mileage = mileage
			car.save
		end
	end
end