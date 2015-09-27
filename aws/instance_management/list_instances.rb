require 'aws-sdk'
require 'pry'
require 'json'

def get_instance_ids instances_descriptor
  instance_ids = []
  instances_descriptor.each do |instance_descriptor|
    instance_id = instance_descriptor[:instances][0][:instance_id]
    instance_ids << instance_id
  end
  instance_ids
end

ec2 = Aws::EC2::Client.new()
filters = JSON.parse(File.read("instance_filter.json")) || {}
instances_descriptor = ec2.describe_instances(filters)[:reservations]
instance_ids = get_instance_ids instances_descriptor
puts instance_ids