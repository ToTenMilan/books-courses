require 'bunny'
require 'securerandom'

class RpcCallWait
  attr_reader :lock, :condition
  attr_accessor :conn, :channel, :exchange, :reply_queue, :remote_response, :call_id, :queue_name

  def initialize(queue_name)
    @queue_name = queue_name
    @channel = get_channel
    @exchange = channel.default_exchange
  end # initialize

  def get_channel
    return $rabbitmq_channel if $rabbitmq_channel && $rabbitmq_channel.open?
    @conn = Bunny.new('amqp://guest:guest@localhost:5672')
    @conn.start
    $rabbitmq_channel = @conn.create_channel
  end # get_channel

  def response(payload)
    @reply_queue = channel.queue('', exclusive:true, auto_delete:true, :arguments => {})
    self.call_id = SecureRandom.uuid
    puts "#{$$} -> awaiting call with correlation ID #{call_id}"
    puts reply_queue.name
    exchange.publish(payload,
      routing_key: queue_name,
      correlation_id: call_id,
      reply_to: reply_queue.name
    ) # publish
    puts "#{$$} -> Message sent"
    should_finish = false
    that = self
    reply_queue.subscribe() do |delivery_info, properties, payload|
      puts "#{$$} -> subscribe"
      that.remote_response = payload
      should_finish = true
    end # reply_queue.subscribe
    puts "#{$$} -> Waiting"
    10.times do 
      break if should_finish
      puts "#{$$}  -> Checking"
      sleep 1
    end # times
    puts "#{$$} -> -> #{remote_response}"
    remote_response
  end # response

end # RpcCallWait

RpcCallWait.new('get-me-something-queue').response('yolo-message')


# to inspect queues, run:
# docker run -p 5672:5672 -p 15672:15672 rabbitmq:3-management

# and visit localhost:15672