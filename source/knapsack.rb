require_relative 'table'
require_relative 'item'

module SurvivalPack

    class KnapsackOptimizationStrategy

        def solve (item, limit)

            # Implemented by subclass

        end

    end

    # Solves the knapsack 0-1 problem by maximizing value between
    # items given a maximum weight (limit); uses a recursive method
    # that performs redundant calculations and stack allocations; however
    # performs the calculations with minimal space.
    #
    # A memoization technique is applicable to the recursive approach.
    # Unfortunately the cache space required is equivalent to the
    # dynamic programming method.
    #
    # O(2^n) time and O(1) space where:
    #   * n is the number of elements
    #   * W is the maximum weight (limit)

    class RecursiveKnapsackOptimizationStrategy < KnapsackOptimizationStrategy

        def initialize (items, limit)

            @items = items

        end

        def solve (item, limit)

            if item == 0
                return 0
            end

            index = item - 1

            if @items[index].weight > limit
                return solve(index, limit)
            else
                return [
                    solve(index, limit),
                    solve(index, limit - @items[index].weight) +
                        @items[index].value
                ].max
            end

        end

    end

    # Solves the knapsack 0-1 problem by maximizing the value between
    # items given a maximum weight (limit); uses a dynamic programming
    # method that precomputes best values for all items up to the
    # weight limit.
    #
    # O(nW) time and O(nW) space where:
    #
    #   * n is the number of elements
    #   * W is the maximum weight (limit)

    class DynamicKnapsackOptimizationStrategy < KnapsackOptimizationStrategy

        def initialize (items, limit)

            @table = Table.new items.length + 1, limit + 1

            # Precompute the best value between all items
            # for a maximum weight

            for i in 0 .. items.length - 1
                for w in 1 .. limit + 1
                    if items[i].weight > w
                        @table[i + 1, w] = @table[i, w]
                    else
                        @table[i + 1, w] = [
                            @table[i, w],
                            @table[i, w - items[i].weight] + items[i].value
                        ].max
                    end
                end
            end

        end

        def solve (item, limit)

            # Return the best value (pre-computed) for the
            # specified item index given the supplied weight limit

            return @table[item, limit]

        end

    end

    class Knapsack

        def initialize ()

            @items = Array.new

        end

        # Adds an item to the Knapsack

        def push (item)

            @items << item

        end

        # Finds an optimal set of items given a maximum weight (limit)
        # that maximizes item value. Solves the knapsack 0-1 problem.

        def optimize (limit = 1)

            if limit <= 0
                raise ArgumentError, 'Weight limit must be > 0'
            end

            result = Knapsack.new
            strategy = DynamicKnapsackOptimizationStrategy.new @items, limit

            (0 .. @items.length - 1).reverse_each do |i|
                if strategy.solve(i + 1, limit) != strategy.solve(i, limit)
                    limit -= @items[i].weight
                    result.push @items[i]
                end
            end

            result

        end

        def to_json (options = {})

            @items.to_json options

        end

    end

end
