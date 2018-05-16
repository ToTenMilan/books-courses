require '../interpreter/file_interpreter'
require 'finder'
require 'singleton'
require_relative 'backup'

class PackRat
  include Singleton

  def initialize
    @backups = []
  end

  def register_backup(backup)
    @backups << backup
  end

  def run
    threads = []
    @backups.each do |backup|
      threads << Thread.new { backup.run }
    end
    threads.each { |t| t.join }
  end
end

eval(File.read('backup.pr'))
PackRat.instance.run

# Backup.new do |b|
#   b.backup '/home/milan/Documents/aukcje'
#   b.to '/home/milan/Documents/aukcje_backup'
#   b.interval 60
# end

# Backup.new do |b|
#   b.backup '/home/milan/Documents/aukcje'
#   b.to '/home/milan/Documents/aukcje_backup'
#   b.interval 60
# end