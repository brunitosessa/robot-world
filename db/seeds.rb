#Car Models
Model.create(name:"Peugeot")
Model.create(name:"Renault")
Model.create(name:"Fiat")
Model.create(name:"Hyundai")
Model.create(name:"Ferrari")
Model.create(name:"Mustang")
Model.create(name:"Honda")
Model.create(name:"Porsche")
Model.create(name:"Kia")
Model.create(name:"Ford")


#Cars
car = Car.create(model_id: 1, year:1999, price: 200000, cost_price: 20000)

#Part Types - Wheels, Chasis, Engine, etc
PartType.create(name:"Chasis", assembly_line: "Basic_Structure")
PartType.create(name:"W1", assembly_line: "Basic_Structure")
PartType.create(name:"W2", assembly_line: "Basic_Structure")
PartType.create(name:"W3", assembly_line: "Basic_Structure")
PartType.create(name:"W4", assembly_line: "Basic_Structure")
PartType.create(name:"Engine", assembly_line: "Basic_Structure")
PartType.create(name:"Seat1", assembly_line: "Basic_Structure")
PartType.create(name:"Seat2", assembly_line: "Basic_Structure")
PartType.create(name:"Laser", assembly_line: "Electronic_Devices")

#Parts
#Car 1 (COMPLETE_PARTS)
Part.create(part_type_id: 1, defect: false, car_id: car.id)
Part.create(part_type_id: 2, defect: false, car_id: car.id)
Part.create(part_type_id: 3, defect: false, car_id: car.id)
Part.create(part_type_id: 4, defect: false, car_id: car.id)
Part.create(part_type_id: 5, defect: false, car_id: car.id)
Part.create(part_type_id: 6, defect: false, car_id: car.id)
Part.create(part_type_id: 7, defect: false, car_id: car.id)
Part.create(part_type_id: 8, defect: false, car_id: car.id)
Part.create(part_type_id: 9, defect: false, car_id: car.id)

#Cars
car.computer = Computer.new
car.status = "complete"
car.location = 'warehouse'
car.is_painted = true
car.save