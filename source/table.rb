module SurvivalPack

    # Encapsulates a two-dimensional matrix of artbitrary size
    # and provides simple array accessor syntax [i, j] for accessing
    # and mutating table values.

    class Table

        # Builds a new table with +width+ columns and +height+ rows
        # and all cells initialized to zero.

        def initialize (width, height)
            @width = width
            @data = Array.new width * height
            for i in 0 .. width * height
                @data[i] = 0
            end
        end

        def [] (i, j)
            @data[j * @width + i]
        end

        def []= (i, j, value)
            @data[j * @width + i] = value
        end

    end

end
