FileUtils.mkdir_p('log')
require 'logger'
DB.loggers << Logger.new('log/sequel.log')

RSpec.configure do |c|
  c.before(:suite) do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    DB[:expenses].truncate
  end

  c.before(:example) do |example|
    DB.log_info("Starting example: #{example.description}")
  end

  c.around(:example, :db) do |example|
    DB.transaction(rollback: :always) { example.run }
  end

  c.after(:example) do |example|
    DB.log_info("ending example: #{example.description}")
  end
end
