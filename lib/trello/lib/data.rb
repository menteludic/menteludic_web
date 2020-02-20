require 'wisper'

module Trello
  class Data
    include ::Wisper::Publisher

    def initialize(events)
      @events = events
    end

    def saveData(event_data, lists, cards)
      @data ||= []
      @data << {
        event: add_slug(event_data),
        lists: lists,
        cards: cards
      }
    end

    def process(http)
      @events.each do |event_data|
        broadcast(:info, "Processing event: #{event_data[:name]}")
        event = Trello::Event.new(event_data)
        event.subscribe(self)
        event.process(http)
      end
      broadcast(:saveData, @data)
    end

  private

    def add_slug(event_data)
      event_data.merge(slug: slug(event_data[:name]) )
    end

    def slug(text)
      text.to_slug.normalize.to_s
    end
  end
end
