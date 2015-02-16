require 'grape'
require 'rack'

require_relative 'v1/service'

module SurvivalPack

    class API < Grape::API

        mount SurvivalPack::APIv1

    end

end

Rack::Handler::WEBrick.run SurvivalPack::API
