require "rubygems"
require "bunny"
require "json"

# Returns a connection instance
conn = Bunny.new ENV['CLOUDAMQP_URL']
# The connection will be established when start is called
conn.start

# Create a channel in the TCP connection
ch = conn.create_channel
# Declare a queue with a given name, examplequeue. In this example is a durable shared queue used.
q  = ch.queue("examplequeue", :durable => true)

# Method for the PDF processing
def pdf_processing(json_information_message)
  puts "Handling pdf processing for:"
  puts json_information_message['email']
  sleep 5.0
  puts "pdf processing done"
end

# Set up the consumer to subscribe from the queue
q.subscribe(:block => true) do |delivery_info, properties, payload|
  json_information_message = JSON.parse(payload)
  pdf_processing(json_information_message)
end