module SpecialsHelper

  def generate_url(type, car)
    issue_tokens = []
    if current_user.id != car.user_id
      nil
    elsif type.class.name == 'Issue'
      @token = SecureRandom.urlsafe_base64
      @permission = Permission.new(car_id: car.id, issue_id: type.id, report_type: type.class.name, token: @token)
      if !@permission.save
        nil
      else
        # request.host_with_port.to_s + "/specials/?&report_type=#{type.class.name}&issue_id=#{type.id}&car_id=#{car.id}&token=#{@token}"
        issue_tokens.push("localhost:3000" + "/specials/?&report_type=#{type.class.name}&issue_id=#{type.id}&car_id=#{car.id}&token=#{@token}")
        issue_tokens.push("localhost:3000" + "/cars/#{car.id}/issues/#{type.id}/?&token=#{@token}")
        issue_tokens
      end
    elsif type.class.name == 'Maintenance'
      @token = SecureRandom.urlsafe_base64
      @permission = Permission.new(car_id: car.id, report_type: type.class.name, token: @token)
      if !@permission.save
        nil
      else
        # request.host_with_port.to_s + "/specials/?&report_type=#{type.class.name}&car_id=#{car.id}&token=#{@token}"
        issue_tokens.push("localhost:3000" + "/specials/?&report_type=#{type.class.name}&car_id=#{car.id}&token=#{@token}")
        issue_tokens.push("localhost:3000" + "/cars/#{car.id}/maintenances/?&token=#{@token}")
        issue_tokens
      end
    else
      nil
    end
  end

end
