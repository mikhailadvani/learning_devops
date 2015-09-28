require 'aws-sdk'
require 'pry'
require '../../../aws/instance_management/models/aws_instance'
instance_ids = ARGV
instance_ids.each do |instance_id|
  AwsInstance.new(instance_id).stop_instance
end
