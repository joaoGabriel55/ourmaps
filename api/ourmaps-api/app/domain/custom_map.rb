# frozen_string_literal: true

module Domain
  class InvalidCustomMap < StandardError; end

  class CustomMap
    attr_accessor :id, :name, :description,
      :content, :owner, :colaborators, :created_at, :updated_at

    def initialize(
      id: nil,
      name: nil,
      description: nil,
      content: [],
      owner: nil,
      colaborators: []
    )

      validate(id:, name:, owner:)

      @id = id
      @name = name
      @description = description
      @content = content
      @owner = owner
      @colaborators = colaborators
      @created_at = DateTime.now
      @updated_at = nil
    end

    def to_hash
      {
        id:,
        name:,
        description:,
        content:,
        owner: owner.to_hash,
        colaborators: colaborators&.map(&:to_hash),
        created_at:,
        updated_at:
      }
    end

    private

    def validate(id:, name:, owner:)
      if id.nil?
        raise InvalidCustomMap, 'Id is required'
      elsif name.nil?
        raise InvalidCustomMap, 'Name is required'
      elsif owner.nil?
        raise InvalidCustomMap, 'Owner is required'
      end
    end
  end
end
