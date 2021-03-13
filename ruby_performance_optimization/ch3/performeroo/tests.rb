
# ActiveRecord only
Measure.run(gc: :disable) { Thing.all.includes(:minions).load }
{"2.7.1":{"gc":"disable","time":3.95,"gc_count":0,"memory":"0 MB"}}

# sql
q = 'select id, col1, array_agg(mcol4) from things
inner join
(select thing_id, mcol4 from minions) minions
on (things.id = minions.thing_id)
group by id, col1'

Measure.run { Thing.find_by_sql(q) }
# {"2.7.1":{"gc":"enable","time":0.32,"gc_count":0,"memory":"0 MB"}}



# find_each and find_in_batches
ObjectSpace.each_object(Thing).count

Thing.find_in_batches { |batch| GC.start; puts ObjectSpace.each_object(Thing).count } # not more than 2000 objects are in memory at once
GC.start

ObjectSpace.each_object(Thing).count


# compare with
ObjectSpace.each_object(Thing).count

Thing.all.each_with_index { |thing, i|
  if i % 1000 == 0
    GC.start
    puts ObjectSpace.each_object(Thing).count
  end
  }; nil # 10000 objects all the time



# rendering partials in loops is slow
# solution
<%= render :partial => ​'object'​, :collection => @objects %>
# or
<%= render @objects %>


