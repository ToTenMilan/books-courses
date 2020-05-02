# Antipattern
# lib/tasks/twitter.rake
namespace :twitter do
  task search: :environment do
    puts "searching ..."
    Twitter.search(...).each do |result|
      puts "alert"
      alert = Alert.create(body: result)
      alert.save_cache_file!
    end
    puts "all done"
  end
end

# test/unit/twitter_task_test.rb
class TwitterTaskTest < ActiveSupport::TestCase
  self.use_transactional_fixtures = false

  context "rake twitter:search" do
    setup do
      # task will run in separate process than test. This means:
      # 1. cant mock nor stub
      # 2. connect to database separately, so db wont be cleaned up after tests by test config
      # is also very slow
      @out = `cd #{Rails.root} && rake twitter:search 2>&1`
    end

    should "print s message at the beginning" do
      assert_match /Searching/i, @out
    end

    should "save cache files" do
      # need to take care of temporary files after test
      # ...
    end

    should "find all tweets containing @somerealusername" do
      # very unreliable test
    end

    should "print a messsage when done" do
      assert_match /all done/i, @out
    end
  end
end



# solution - move logic to class method
# app/models/alert.rb
class Alert < ActiveRecord::Base
  def self.create_all_from_twitter_search(output = $stdout)
    output.puts "searching ..."
    Twitter.search(...).each do |result|
      output.puts "alert"
      alert = Alert.create(body: result)
      alert.save_cache_file!
    end
    output.puts "all done"
  end
end

# lib/tasks/twitter.rake
namespace :twitter do
  task search: :environment do
    Alert.create_all_from_twitter_search
  end
end

# test/unit/alert_test.rb
class AlertTest < ActiveSupport::TestCase
  context "create_all_from_twitter_search" do
    setup do
      # test wont hit the network, and wont touch the filesystem
      Alert.any_instance.stubs(:save_cache_file!)
      Twitter.stubs(:search).returns([])
      @output = StringIO.new
    end

    should "print s message at the beginning" do
      Alert.create_all_from_twitter_search(@output)
      assert_match /Searching/i, @output.string
    end

    should "print a message for each result" do
      Twitter.stubs(:search).returns(%w[ one two ])
      Alert.create_all_from_twitter_search(@output)
      assert_match /one/i, @output.string
      assert_match /two/i, @output.string
    end

    should "save cache files" do
      Twitter.stubs(:search).returns(%w[ one ])
      alert = mock('alert')
      alert.expects(:save_cache_file!)
      Alert.stubs(:create).returns(alert)
      Alert.create_all_from_twitter_search(@output)
    end

    should "find all tweets containing @somerealusername" do
      Twitter.expects(:search).with('@somefakeusername').returns(['body'])
      Alert.create_all_from_twitter_search(@output)
    end

    should "print a messsage when done" do
      Alert.create_all_from_twitter_search(@output)
      assert_match /all done/i, @output.string
    end
  end
end
