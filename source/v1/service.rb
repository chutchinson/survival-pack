require 'rubygems'
require 'json'
require 'grape'

require_relative '../knapsack.rb'
require_relative '../item.rb'

module SurvivalPack

    class APIv1 < Grape::API

        # Endpoint configuration

        Version = 'v1'
        Resource = 'survival-pack'

        version Version, using: :path
        format :txt

        # REST resource definitions

        resource Resource do

            get do

                backpack = Knapsack.new

                backpack.push Item.new('ammo', 9, 150)
                backpack.push Item.new('tuna', 13, 35)
                backpack.push Item.new('water', 153, 200)
                backpack.push Item.new('spam', 50, 160)
                backpack.push Item.new('knife', 15, 60)
                backpack.push Item.new('hammer', 68, 45)
                backpack.push Item.new('rope', 27, 60)
                backpack.push Item.new('saw', 39, 40)
                backpack.push Item.new('towel', 23, 30)
                backpack.push Item.new('rock', 52, 10)
                backpack.push Item.new('seed', 11, 70)
                backpack.push Item.new('blanket', 32, 30)
                backpack.push Item.new('skewer', 24, 15)
                backpack.push Item.new('dull-sword', 48, 10)
                backpack.push Item.new('oil', 73, 40)
                backpack.push Item.new('peanuts', 42, 70)
                backpack.push Item.new('almonds', 43, 75)
                backpack.push Item.new('wire', 22, 80)
                backpack.push Item.new('popcorn', 7, 20)
                backpack.push Item.new('rabbit', 18, 12)
                backpack.push Item.new('beans', 4, 50)
                backpack.push Item.new('laptop', 30, 10)

                JSON.pretty_generate backpack.optimize(400)

            end

        end

    end

end
