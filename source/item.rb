require 'json'

module SurvivalPack

    class Item

        def initialize (name, weight, value)

            @name = name
            @weight = weight
            @value = value

        end

        def to_json (options = {})

            model = {
                name: @name,
                weight: @weight,
                value: @value
            }

            model.to_json options

        end

        attr_reader :name
        attr_reader :weight
        attr_reader :value

    end

end
