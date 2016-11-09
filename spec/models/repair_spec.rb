require 'rails_helper'

RSpec.describe Repair, type: :model do
  before(:all) do
    User.destroy_all
    Car.destroy_all
    Issue.destroy_all
    Repair.destroy_all
    Maintenance.destroy_all
    Permission.destroy_all
    Shop.destroy_all
    Ticket.destroy_all
    Comment.destroy_all
    @lindeman = User.create(first_name: "Andy", last_name: "Lindeman", password: "password", email: "tester@test.com")
    @travis = User.create(first_name: "Bob", last_name: "Builder", password: "password", email: "tester2@test.com", mech_status: true)
    @star = Car.create(user_id: @lindeman.id, mileage: 100, vin: "11111111111111111")
    @dust = Car.create(user_id: @lindeman.id, mileage: 20, vin: "11111111111111119")
    @engine = Issue.create(car_id: @star.id, title: "Tail Light Problem", description: "The light will not turn on")
    @tail_light = Issue.create(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true)
    @back_light = Issue.create(car_id: @dust.id, title: "Engine won't turn on", description: "See Title")
    @oreilly = Shop.create(name: "O'Reilly", mechanic_id: @travis.id, address: "636 Spruce St.", city: "San Francisco", state: "CA", zip_code: "94118")
    @tail_light_fix = Repair.create(repairable: @tail_light, shop_id: @oreilly.id, title: "Tail Light Wiring", description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
    @engine_fix = Repair.create(repairable: @engine, shop_id: @oreilly.id, title: "Engine dead", description: "Engine is dead. Please buy a new one", mileage: 3200, date_completed: "11/04/2016")
    @oil_change = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "Scheduled Oil Change", description: "See Title", mileage: 200, date_completed: "11/04/2016")
    @alignment = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
    @tire_change = Maintenance.create(car_id: @dust.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
    @stranded = Ticket.create(title: "SOS", car_id: @star.id, user_id: @lindeman.id,  description: "Please come get me")
    @stranded_repair = Repair.create(repairable: @stranded, shop_id: @oreilly.id, title: "Engine dead", description: "Engine is dead. Please buy a new one", mileage: 3200, date_completed: "11/04/2016")
  end

  context "repair creation" do
    it "ensures that we have the base variables needed for testing" do
      expect(Repair.all).to match_array([@tail_light_fix, @engine_fix, @stranded_repair])
    end

    it "ensures that a shop_id can be optional" do
      @test = Repair.new(repairable: @stranded, title: "Engine dead", description: "Engine is dead. Please buy a new one", mileage: 3200, date_completed: "11/04/2016")
      expect(@test.valid?).to eq(true)
    end
  end

  context "parent assocation" do
    it "belongs to a parent issue" do
      expect(@tail_light_fix.repairable).to eq(@tail_light)
    end

    it "belongs to a parent ticket" do
      expect(@stranded_repair.repairable).to eq(@stranded)
    end
  end

  context "Presence validations" do
    it "- title" do
      @test = Repair.new(repairable: @tail_light, shop_id: @oreilly.id, description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
      expect(@test.valid?).to eq(false)
    end

    it "- description" do
      @test = Repair.new(repairable: @tail_light, shop_id: @oreilly.id, title: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
      expect(@test.valid?).to eq(false)
    end

    it "- mileage" do
      @test = Repair.new(repairable: @tail_light, shop_id: @oreilly.id, title: "Tail light wiring messing with the engine", description: "Tail light wiring messing with the engine", date_completed: "11/04/2016")
      expect(@test.valid?).to eq(false)
    end

    it "- date_completed" do
      @test = Repair.new(repairable: @tail_light, shop_id: @oreilly.id, title: "Tail light wiring messing with the engine", description: "Tail light wiring messing with the engine", mileage: 3200)
      expect(@test.valid?).to eq(false)
    end
  end

  context "Title validations" do
    it "Doesn't allow a title to be more than 64 characters" do
      @test = Repair.new(repairable: @tail_light, shop_id: @oreilly.id, title: "1234567890123456789012345678901234567890123456789012345678901234", description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
      expect(@test.valid?).to eq(true)

      @test = Repair.new(repairable: @tail_light, shop_id: @oreilly.id, title: "12345678901234567890123456789012345678901234567890123456789012345", description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
      begin
        @test.save
      rescue
        @test = nil
      end

      expect( @test ).to eq(nil)
    end
  end

  context "Shop validation" do
    it "checks validity of shop if shop_id is supplied" do
      @test = Repair.new(repairable: @tail_light, shop_id: 0, title: "1234567890123456789012345678901234567890123456789012345678901234", description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
      expect(@test.valid?).to eq(false)
      @test = Repair.new(repairable: @tail_light, shop_id: @oreilly.id, title: "1234567890123456789012345678901234567890123456789012345678901234", description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
      expect(@test.valid?).to eq(true)
    end
  end
end
