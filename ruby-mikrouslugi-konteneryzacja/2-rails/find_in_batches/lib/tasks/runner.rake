namespace :runner do
  desc "Przykładowe zadanie z find_in_batches"
  task :sample => :environment do
    STDOUT.sync = true
    puts "runner:sample ==> START ==> " + Time.now.to_s
    @e = Execution.new
    @e.action = "runner:sample"
    @e.save!
    mem = GetProcessMem.new
    puts mem.mb
    #
    Readout.find_in_batches(:batch_size => 1_000_000).each do |group|
      group.each_with_index do |readout,index|
        # puts "#{$$} -> #{index} -> #{readout.id}"
      end # group.each_with_index
    end # find_in_batches
    @e.touch
    puts "runner:sample ==> FINISH ==> " + Time.now.to_s
    mem = GetProcessMem.new
    puts mem.mb
  end # sample
end # runner