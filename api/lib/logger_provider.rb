# frozen_string_literal: true

require "logger"

class LoggerProvider
  def initialize
    @logger = Logger.new($stdout)
  end

  attr_reader :logger

  def info(message)
    @logger.info(message)
  end

  def error(message)
    @logger.error(message)
  end

  def debug(message)
    @logger.debug(message)
  end

  def warn(message)
    @logger.warn(message)
  end
end
