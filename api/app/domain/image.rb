# frozen_string_literal: true

class Image
  attr_accessor :id, :image_link, :custom_map_id, :uploaded_at

  def initialize(image_link:, custom_map_id:)
    @id = IdProvider.next_id
    @image_link = image_link
    @custom_map_id = custom_map_id
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
end
