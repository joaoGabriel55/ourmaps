# frozen_string_literal: true

class LoggerProvider
  def initialize
  end

  attr_reader :logger

  def info(message)
    Rails.logger.info(message)
  end

  def error(message)
    Rails.logger.error(message)
  end

  def debug(message)
    Rails.logger.debug(message)
  end

  def warn(message)
    Rails.logger.warn(message)
  end
end
