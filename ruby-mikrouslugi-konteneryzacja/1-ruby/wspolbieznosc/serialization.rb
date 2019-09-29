Tire = Struct.new(:radius, :pressure)
reader, writer = IO.pipe

fork do
  reader.close
  tire = Tire.new(7, 28)
  tire_data = Marshal.dump(tire)
  writer.write tire_data # send serialized from child ...
end # fork

writer.close
tire_data = reader.gets
tire = Marshal.load(tire_data) # to parent, and print
puts tire.inspect

# #<struct Tire radius=7, pressure=28>