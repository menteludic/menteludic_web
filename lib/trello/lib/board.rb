require 'json'

module Trello
  class Board
    def initialize(id, http)
      @id = id
      @http = http
    end

    def getCardsWithLabel(labelId, &block)
      mapCardIdAndLabels do |data|
        yield(data['id']) if hasLabelId(data['labels'], labelId)
      end
    end

  private

    def hasLabelId(labels, labelId)
      labels.map{|l| l['id']}.include?(labelId)
    end

    def mapCardIdAndLabels(&block)
      response = @http.getCardIdAndLabels(@id)
      JSON.parse(response.body).each { |data| yield(data) }
    end
  end
end
