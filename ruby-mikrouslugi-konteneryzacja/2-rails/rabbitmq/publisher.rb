require 'bunny'

class Publisher

  def self.publish(queue, message = {})
    q = channel.queue(queue)
    channel.default_exchange.publish(Marshal.dump(message), routing_key: q.name)
  end # publish

  def self.channel
    @channel ||= connection.create_channel
  end #channel

  def self.connection
    @connection ||= Bunny.new.tap do |c|
      c.start
    end
  end # connection

end # Publisher

# one-way publishing
# example usage
Publisher.publish('some-publisher-queue', message = { 'yolo': 'what' } )

# to inspect queues, run:
# docker run -p 5672:5672 -p 15672:15672 rabbitmq:3-management

# and visit localhost:15672