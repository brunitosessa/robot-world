module Utilities
    def random_model
        Model.all.to_a.sample
    end

    def random_year
        (1990..2021).to_a.sample
    end

    def random_price
        (100000..1000000).to_a.sample
    end

    def random_cost_price
        (10000..80000).to_a.sample
    end

    # Generates random Basic Parts for 1th line (10% posibility to get defect on part)
    def random_parts_1
        parts = []
        (1..8).each do |id|
            parts.push(Part.new(part_type_id: id, defect: ([false]*9 << true).sample))
        end
        parts
    end

    # Generates random Basic Parts for 2nd line (10% posibility to get defect on part)
    def random_parts_2
        parts = []
        parts.push(Part.new(part_type_id: 9, defect: ([false]*9 << true).sample))
        parts.push(CarComputer.new(part_type_id: 10, defect: ([false]*9 << true).sample))
        parts
    end
end