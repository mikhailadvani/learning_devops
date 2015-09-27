require 'aws-sdk'
require 'pry'
instance_ids = ARGV
ec2 = Aws::EC2::Client.new()
resp = ec2.start_instances({instance_ids: instance_ids})
start_time = Time.now()
ec2.wait_until(:instance_running, {instance_ids: instance_ids}) {
  puts "Waiting"
}
stop_time = Time.now()
puts "Time taken to start instance: #{stop_time - start_time}"
