require 'json'
require 'wisper'
require 'babosa'

module Trello
  class Event
    include ::Wisper::Publisher

    def initialize(event_data)
      @event_data = event_data
    end

    def process(http)
      broadcast(:info, 'Processing data....')
      lists, cards = collectCards(@event_data[:labelId], http)
      broadcast(:saveData, @event_data, lists, cards)
    end

  private
    def getRequest(url, query, response)
      broadcast(:getRequest, url, query, response)
    end

    def board(http)
      @board ||= Board.new(@event_data[:boardId], http)
    end

    def collectCards(labelId, http)
      lists = {}
      cards = {}
      board(http).getCardsWithLabel(labelId) do |id|
        card = loadCard(id, http)

        lists[card.listData['id']] ||= {}
        if !lists[card.listData['id']][:id]
          lists[card.listData['id']] = {
            id: card.listData['id'],
            name: card.listData['name'],
            slug: slug(card.listData['name']),
            numcards: 0
          }
        end
        lists[card.listData['id']][:numcards] += 1;
        cards[card.data['id']] ||= {}
        cards[card.data['id']] = data(card)
      end
      [lists, cards]
    end

    def loadCard(cardId, http)
      @cards ||= {}
      return @cards[cardId] if @cards[cardId]
      @cards[cardId] = Card.new(cardId, http)
      @cards[cardId]
    end

    def data(card)
      {
        id: card.data['id'],
        url: card.data['url'],
        name: card.data['name'],
        desc: card.data['desc'],
        idList: card.data['idList'],
        cover: card.attachmentCoverData['url']
      }
    end

    def slug(text)
      text.to_slug.normalize.to_s
    end
  end
end
