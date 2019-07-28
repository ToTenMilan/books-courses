setup do # setup method is changing this passed block to proc (unexecuted function), to be called later
  puts 'Setting up sky'
  @sky_height = 100
end

setup do
  puts 'Setting up mountains'
  @mountains_height = 200
end

event 'the sky is falling' do # event method is changing this passed block to proc (unexecuted function), to be called later
  @sky_height < 300
end

event 'its getting closer' do
  @sky_height < @mountains_height
end

event 'oops, too late' do
  @sky_height < 0
end