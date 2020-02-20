require 'json'

module Trello
  class Card
    FIELDS = %w(due desc name idAttachmentCover url idList)

    def initialize(id, http)
      @id = id
      @http = http
    end

    def data
      @data ||= JSON.parse(@http.getCardData(@id, FIELDS).body)
    end

    def attachmentCoverData
      JSON.parse(@http.getCardAttachmentsData(@id, idAttachmentCover, 'url').body)
    end

    def listData
      JSON.parse(@http.getListData(idList, 'name').body)
    end

  private

    def idAttachmentCover
      data['idAttachmentCover']
    end

    def idList
      data['idList']
    end
  end
end
