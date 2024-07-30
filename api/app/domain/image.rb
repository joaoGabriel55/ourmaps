# frozen_string_literal: true

module Domain
  class Image
    attr_accessor :id, :image_link, :uploaded_at

    def initialize(id: nil, image_link: nil)
      validate(id:, image_link:)

      @id = id
      @image_link = image_link
      @uploaded_at = DateTime.now
    end

    def to_hash
      {
        id:,
        image_link:,
        custom_map_id:,
        uploaded_at:
      }
    end

    private

    def validate(id:, image_link:)
      if id.nil?
        raise InvalidImage, 'Id is required'
      elsif image_link.nil?
        raise InvalidImage, 'Image link is required'
      end
    end
  end
end
