class SimpleLogger
  attr_accessor :level

  ERROR = 1
  WARNING = 2
  INFO = 3

  def initialize
    @log = File.open("simple_logger.txt", "w")
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

  # loginc added by stdlib 'Singleton' module
  @@instance = SimpleLogger.new

  def self.instance
    @@instance
  end

  private_class_method :new
end

# logger = SimpleLogger.new
# logger.level = SimpleLogger::INFO

# logger.info('doing some')
# logger.info('and something more')

# logger1 = SimpleLogger.instance
# logger2 = SimpleLogger.instance
# puts logger1.inspect
# puts logger2.inspect
# puts logger1.__id__ === logger2.__id__

SimpleLogger.instance.info('Computer wins chess game.')
SimpleLogger.instance.warning('AE-35 hardware failure predicted.')
SimpleLogger.instance.error('HAL-9000 malfunction, take emergency action!')

smuteczek = SimpleLogger.new