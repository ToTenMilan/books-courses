require 'bunny'
require 'securerandom'

class RpcCallMutex
  attr_reader :lock, :condition
  attr_accessor :conn, :channel, :exchange, :reply_queue, :remote_response, :call_id, :queue_name

  def initialize(queue_name)
    @queue_name = queue_name
    @channel = get_channel
    @exchange = channel.default_exchange
    @reply_queue = channel.queue('', exclusive:true, auto_delete:true)
  end # initialize

  def get_channel
    return $rabbitmq_channel if $rabbitmq_channel && $rabbitmq_channel.open?
    @conn = Bunny.new('amqp://guest:guest@localhost:5672')
    @conn.start
    $rabbitmq_channel = @conn.create_channel
  end # get_channel

  def response(payload)
    @lock = Mutex.new
    @condition = ConditionVariable.new
    response_callback(reply_queue)
    self.call_id = SecureRandom.uuid
    puts "Awaiting call with correlation ID #{call_id}"
    puts reply_queue.name
    exchange.publish(payload,
      routing_key: queue_name,
      correlation_id: call_id,
      reply_to: reply_queue.name
    ) # publish
    lock.synchronize { condition.wait(lock) }
    remote_response
  end # response

  private

  def response_callback(reply_queue)
    that = self
    reply_queue.subscribe do |delivery_info, properties, payload|
      if properties[:correlation_id] == that.call_id
        that.remote_response = payload
        that.lock.synchronize { that.condition.signal }
        that.reply_queue.delete rescue nil
      end # if
    end # reply_queue.subscribe
  end # response_callback

end # RpcCallMutex

RpcCallMutex.new('get-me-something-queue').response('yolo-message')


# to inspect queues, run:
# docker run -p 5672:5672 -p 15672:15672 rabbitmq:3-management

# and visit localhost:15672