# frozen_string_literal: true

class String
  def camelize
    split('_').inject([]) do |buffer, e|
      buffer.push(buffer.empty? ? e : e.capitalize)
    end.join
  end
end
