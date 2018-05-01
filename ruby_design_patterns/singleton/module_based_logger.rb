module ModuleBasedLogger
  ERROR = 1
  WARNING = 2
  INFO = 3

  @@log = File.open('module_based_logger.txt', 'w')
  @@level = WARNING

  def self.error(msg)
    @@log.puts(msg)
    @@log.flush
  end

  def self.warning(msg)
    @@log.puts(msg) if @@level >= WARNING
    @@log.flush
  end

  def self.info(msg)
    @@log.puts(msg) if @@level >= INFO
    @@log.flush
  end

  def self.level=(new_level)
    @@level = new_level
  end

  def self.level
    @@level
  end
end

ModuleBasedLogger.level = ModuleBasedLogger::INFO

ModuleBasedLogger.info('Computer wins chess game.')
ModuleBasedLogger.warning('AE-35 hardware failure predicted.')
ModuleBasedLogger.error('HAL-9000 malfunction, take emergency action!')
