# frozen_string_literal: true

module Domain
  class InvalidImage < StandardError; end

  class Image
    attr_accessor :id, :url, :uploaded_at

    def initialize(id: nil, url: nil)
      validate(id:, url:)

      @id = id
      @url = url
      @uploaded_at = DateTime.now
    end

    def to_hash
      {
        id:,
        url:,
        uploaded_at:
      }
    end

    private

    def validate(id:, url:)
      if id.nil?
        raise InvalidImage, 'Id is required'
      elsif url.nil?
        raise InvalidImage, 'Image link is required'
      end
    end
  end
end
