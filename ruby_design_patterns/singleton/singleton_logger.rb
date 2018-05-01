require 'singleton'

class SingletonLogger
  include Singleton

  attr_accessor :level

  ERROR = 1
  WARNING = 2
  INFO = 3

  def initialize
    @log = File.open("singleton_logger.txt", "w")
    @level = WARNING
    puts 'initialized'
  end

  def error(msg)
    @log.puts(msg)
    @log.flush
  end

  def warning(msg)
    @log.puts(msg) if @level >= WARNING
    @log.flush
  end

  def info(msg)
    @log.puts(msg) if @level >= INFO
    @log.flush
  end
end

SingletonLogger.instance.info('Computer wins chess game.')
SingletonLogger.instance.warning('AE-35 hardware failure predicted.')
SingletonLogger.instance.error('HAL-9000 malfunction, take emergency action!')
