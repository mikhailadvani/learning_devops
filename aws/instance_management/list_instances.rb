require 'aws-sdk'
require 'pry'

def get_instance_ids instances_descriptor
  instance_ids = []
  instances_descriptor.each do |instance_descriptor|
    instance_id = instance_descriptor[:instances][0][:instance_id]
    instance_ids << instance_id
    puts instance_id
  end
end

ec2 = Aws::EC2::Client.new()
instances_descriptor = ec2.describe_instances[:reservations]
get_instance_ids instances_descriptor