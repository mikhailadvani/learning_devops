require 'aws-sdk'
require 'pry'
require 'json'

ec2 = Aws::EC2::Client.new()
instance_id = ARGV[0]
instance = {instance_ids: [instance_id]}
instance_descriptor = ec2.describe_instances(instance)
File.write("#{instance_id}.json",instance_descriptor.to_h.to_json)