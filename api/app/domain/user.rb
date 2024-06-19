# frozen_string_literal: true

require './app/shared_kernel/id_provider'
require './app/domain/owner'
require './app/domain/colaborator'

class User
  attr_accessor :id, :name, :owner, :colaborator, :created_at, :updated_at

  def initialize(name: nil, owner: nil, colaborator: nil)
    @id = IdProvider.next_id
    @name = name
    @owner = owner
    @colaborator = colaborator
    @created_at = DateTime.now
    @updated_at = nil
  end

  def valid?
    name.present?
  end

  def to_hash
    {
      id:,
      name:,
      owner:,
      colaborator:,
      created_at:,
      updated_at:
    }
  end
end
