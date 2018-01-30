# require "bunny"
# require "thread"

# conn = Bunny.new(:automatically_recover => false)
# conn.start

# ch   = conn.create_channel

# class FibonacciClient
#   attr_reader :reply_queue
#   attr_accessor :response, :call_id
#   attr_reader :lock, :condition

#   def initialize(ch, server_queue)
#     @ch             = ch
#     @x              = ch.default_exchange

#     @server_queue   = server_queue
#     @reply_queue    = ch.queue("", :exclusive => true)

#     @lock      = Mutex.new
#     @condition = ConditionVariable.new
#     that       = self

#     @reply_queue.subscribe do |delivery_info, properties, payload|
#       if properties[:correlation_id] == that.call_id
#         that.response = payload.to_i
#         that.lock.synchronize{that.condition.signal}
#       end
#     end
#   end

#   def call(n)
#     self.call_id = self.generate_uuid

#     @x.publish(n.to_s,
#       :routing_key    => @server_queue,
#       :correlation_id => call_id,
#       :reply_to       => @reply_queue.name)

#     lock.synchronize{condition.wait(lock)}
#     response
#   end

#   protected

#   def generate_uuid
#     # very naive but good enough for code
#     # examples
#     "#{rand}#{rand}#{rand}"
#   end
# end

# client   = FibonacciClient.new(ch, "rpc_queue")
# puts " [x] Requesting fib(5)"
# response = client.call(20x)
# puts " [.] Got #{response}"

# ch.close
# conn.close



require "bunny"

puts "=> Subscribing for messages using explicit acknowledgements model"
puts

connection1 = Bunny.new
connection1.start

connection2 = Bunny.new
connection2.start

connection3 = Bunny.new
connection3.start

ch1 = connection1.create_channel

ch2 = connection2.create_channel

ch3 = connection3.create_channel

x   = ch3.direct("amq.direct")
q1  = ch1.queue("bunny.examples.acknowledgements.explicit", :auto_delete => false)
q1.purge

q1.bind(x).subscribe(:manual_ack => true, :block => false) do |delivery_info, properties, payload|
  # do some work
  sleep(0.2)

  # acknowledge some messages, they will be removed from the queue
  if rand > 0.5
    # FYI: there is a shortcut, Bunny::Channel.ack
    ch1.acknowledge(delivery_info.delivery_tag, false)
    puts "[consumer1] Got message ##{properties.headers['i']}, redelivered?: #{delivery_info.redelivered?}, ack-ed"
  else
    # some messages are not ack-ed and will remain in the queue for redelivery
    # when app #1 connection is closed (either properly or due to a crash)
    puts "[consumer1] Got message ##{properties.headers['i']}, SKIPPED"
  end
end

q2   = ch2.queue("bunny.examples.acknowledgements.explicit", :auto_delete => false)
q2.bind(x).subscribe(:manual_ack => true, :block => false) do |delivery_info, properties, payload|
  # do some work
  sleep(0.2)

  ch2.acknowledge(delivery_info.delivery_tag, false)
  puts "[consumer2] Got message ##{properties.headers['i']}, redelivered?: #{delivery_info.redelivered?}, ack-ed"
end

t1 = Thread.new do
  i = 0
  loop do
    sleep 0.5

    x.publish("Message ##{i}", :headers => { :i => i })
    i += 1
  end
end
t1.abort_on_exception = true

t2 = Thread.new do
  sleep 4.0

  connection1.close
  puts "----- Connection 1 is now closed (we pretend that it has crashed) -----"
end
t2.abort_on_exception = true


sleep 10.0
connection2.close
connection3.close