module RepairsHelper
	def update_mileage(car, mileage)
		if car.mileage <= mileage
			car.mileage = mileage
			car.save
		end
	end
end