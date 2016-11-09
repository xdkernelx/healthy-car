# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Car.destroy_all
Issue.destroy_all
Repair.destroy_all
Maintenance.destroy_all

# @u1 = User.create(first_name: "Sponge", last_name: "Bob", email: "sponge@bob.com", password: "password")
# @c1 = Car.create(vin: "3VWSE69M35M029058", mileage: 32555, user_id: @u1.id)
# @i1 = Issue.create(title: "engine light on", description: "engine light turned on today", urgency: 4, car_id: @c1.id)
# @r1 = Repair.create(title: "fixed engine light", description: "did not turn gas cap all the way", mileage: 32570, date_completed: "11/4/2016", issue_id: @i1.id)
# @m1 = Maintenance.create(title: "oil change", description: "got oil change", mileage: 32755, date_completed: "12/6/2015", car_id: @c1.id, mechanic_id: 1)

@marvan = User.create(first_name: "Marvan", last_name: "T", email: "m@m.com", password: "123456")
@nestor = User.create(first_name: "Nestor", last_name: 'A', email: "test@test.com", password: "jklolp")


@hunter = User.create(first_name: "Hunter", last_name: "C", email: "hunter@car.com", password: "excursion")
@excursion = Car.create(vin: "1FMSU41F8YEE33969", mileage: 178370, year: 2000, make: "Ford", model: "Excursion", engine: "8 Cylinder", user_id: @hunter.id)

Maintenance.create(title: "Tire Rotation", description: "Rotate Tires and Balance Wheels", mileage: 64210, date_completed: "08/06/2004", car_id: @excursion.id)
Maintenance.create(title: "Tire Rotation", description: "Rotate Tires and Balance Wheels", mileage: 68030, date_completed: "30/10/2004", car_id: @excursion.id)


@i6 = Issue.create(title: "Wheel making noise", description: "Noise coming from front wheels", urgency: 3, car_id: @excursion.id)
@r6 = Repair.create(title: "Wheel Bearing", description: "Replace wheel bearing - R/F; R&R Hub bearing assembly; replace Ft. Calipers; Turn brake rotors; SSL - Alignment Thrust Angle", mileage: 64214, date_completed: "10/06/2004", repairable: @i6)

Maintenance.create(title: "Tire Rotation", description: "Rotate Tires and Balance Wheels", mileage: 70571, date_completed: "13/01/2005", car_id: @excursion.id)
Maintenance.create(title: "Tire Rotation", description: "Rotate Tires and Balance Wheels", mileage: 86402, date_completed: "05/10/2005", car_id: @excursion.id)
Maintenance.create(title: "Tire Rotation", description: "Rotate Tires and Balance Wheels; Inflate tire with nitrogen; install FR & Rear brake hose; brake systme flush", mileage: 92652, date_completed: "22/06/2006", car_id: @excursion.id)
Maintenance.create(title: "Tire Rotation", description: "Rotate Tires and Balance Wheels", mileage: 101868, date_completed: "21/06/2007", car_id: @excursion.id)
Maintenance.create(title: "Tire Rotation", description: "Rotate Tires and Balance Wheels", mileage: 113059, date_completed: "19/05/2008", car_id: @excursion.id)

@i5 = Issue.create(title: "Recal", description: "Ford recall", urgency: 2, car_id: @excursion.id)
@r5 = Repair.create(title: "Recall #07S57", description: "Recall #07S57 camshaft position sensor inspection; Installed F7TZ 12K073 B :Sensor - Camshaft Position; Inspect and install camshaft sensor", mileage: 114355, date_completed: "10/07/2008", repairable: @i5)

@i4 = Issue.create(title: "Something is wrong", description: "Car not running smooth", urgency: 3, car_id: @excursion.id)
@r4 = Repair.create(title: "Fuel Injector & LCP Sensor", description: "Replaced fuel injector and LCP sensor", mileage: 121048, date_completed: "24/08/2009", repairable: @i4)

@i3 = Issue.create(title: "Recal", description: "Ford recall", urgency: 2, car_id: @excursion.id)
@r3 = Repair.create(title: "Recall #09S09", description: "Speed control deactivation switch installed 8W7Z 14A411 C :wire ASY; Put jumper harness", mileage: 122120, date_completed: "21/10/2009", repairable: @i3)

@i2 = Issue.create(title: "No strat", description: "Car does not start. Driven 5 hours from georgia, died at stop light", urgency: 5, car_id: @excursion.id)
@r2 = Repair.create(title: "Diag found no start no PCM communication", description: "Replaced Module - engine control - EEC; Replaced regulator - fuel pressure", mileage: 164179, date_completed: "10/06/2015", repairable: @i2)

@i1 = Issue.create(title: "Wheels make noise", description: "Noise coming from wheels when I step on brakes", urgency: 5, car_id: @excursion.id)
@r1 = Repair.create(title: "Wheel bearing and Ball joint", description: "Replace wheel bearing hub.  Assembly with speed sensor.  Torque all bolts. Rec alignment can not with free play in steering and ball joint", mileage: 178027, date_completed: "30/06/2016", repairable: @i1)

Maintenance.create(title: "Full inspection", description: "Performed full inspection; tighten ATF cooler line coupler joints to stop leakage; custome weld 2 broken bolt tabls back onto braket; custom cable terminal fabrication", mileage: 178383, date_completed: "02/08/2016", car_id: @excursion.id)
Maintenance.create(title: "Tire change", description: "Changed all four tires with new BF Goodrich 285/75/16", mileage: 178433, date_completed: "06/09/2016", car_id: @excursion.id)
