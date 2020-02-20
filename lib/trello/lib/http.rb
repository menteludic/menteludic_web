require 'httparty'
require 'wisper'

module Trello
  class HTTP
    include HTTParty
    include ::Wisper::Publisher

    HOST = 'api.trello.com'

    base_uri "https://#{HOST}/"

    def initialize(key, token)
      @key = key
      @token = token
    end

    def getBoardData(boardId)
      getRequest("/1/boards/#{boardId}", { query: baseQuery.merge({ cards: 'all' }) })
    end

    def getCardIdAndLabels(boardId)
      getRequest("/1/boards/#{boardId}/cards", { query: baseQuery.merge({ fields: 'labels' }) })
    end

    def getCardData(cardId, fields)
      getRequest("/1/cards/#{cardId}", { query: baseQuery.merge({ fields: fields }) })
    end

    def getListData(listId, fields)
      getRequest("/1/lists/#{listId}", { query: baseQuery.merge({ fields: fields }) })
    end

    def getCardAttachmentsData(cardId, attachmentId, fields)
      getRequest(
        "/1/cards/#{cardId}/attachments/#{attachmentId}",
        query: baseQuery.merge({ fields: fields })
      )
    end

  private

    def baseQuery
      {
        key: @key,
        token: @token
      }
    end

    def getRequest(url, query)
      response = self.class.get(url, query)
      broadcast(:getRequest, url, query, response)
      response
    end
  end
end