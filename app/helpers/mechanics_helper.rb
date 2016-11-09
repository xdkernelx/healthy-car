module MechanicsHelper
	def mechanic?
		current_user.mech_status == true
	end
end