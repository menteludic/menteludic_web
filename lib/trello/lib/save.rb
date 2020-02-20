require 'json'
require 'wisper'

module Trello
  class Save
    include ::Wisper::Publisher

    def initialize(filename)
      @filename = filename
    end

    def saveData(data)
      broadcast(:info, "Saving: #{pathData}")
      File.write(pathData, data.to_yaml)
    end

  private

    def pathData
      "./data/#{@filename}.yml"
    end
  end
end
