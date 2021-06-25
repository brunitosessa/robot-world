require 'utilities'

class CarFactory
    include Utilities

    attr_reader :car

    def initialize(car=nil)
        if (car)
            @car = car
        else
            reset
        end
    end

    # Give us an empty car in the factory
    def reset
        @car = Car.new
        @car.model= random_model 
        @car.year=Time.current.year
    end
    

    # Calls 1th line of car production
    def basic_structure(basic_parts)
        if parts_ok?("Basic_Structure", basic_parts)
            @car.parts << basic_parts
            @car.status = "Basic_Structure"
            # Add to events
            @car.events << Event.new(name: "Basic Structure Done")
            @car.save
        else
            puts "Error en partes enviadas"
        end
    end

    # Calls 2nd line of car production
    def electronic_devices(electronic_parts, computer)
        if parts_ok?("Electronic_Devices", electronic_parts)
            @car.parts << electronic_parts
            @car.computer = computer
            @car.status = "Electronic_Devices"
            # Add to events
            @car.events << Event.new(name: "Electronic Devices Done")
            @car.save
        else
            puts "Error en partes enviadas"
        end
    end

    # Call 3th line of car production
    def painting_and_final_details
        @car.is_painted = true
        @car.location = "warehouse"
        @car.status = "complete"
        # Add to events
        @car.events << Event.new(name: "Complete in Warehouse")
        @car.save
    end

    #Returns complete car
    def Car
        car = @car
        reset
        car
    end


    def parts_ok?(assembly_line, parts)
        # Compare received parts with corresponding parts of assembly line
        # Part_type between (1,8) Basic Structure
        # Part_type between (9) Electronic Devices

        # ids_parts_types contains all ids of part_types corresponding to that assembly_line
        ids_parts_types = PartType.where("assembly_line = ?", assembly_line).map(&:id)

        # ids_parts contains all ids of part_types in the parts received
        ids_parts = parts.map(&:part_type).map(&:id)
        

        # Check that every part has a part_type of corresponding assembly line
        # Check for no repetition of a part
        (ids_parts_types - ids_parts).empty? && ids_parts.count == ids_parts_types.count 
    end
end