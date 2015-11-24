require 'aws-sdk'
require 'pry'
require '../../../lib/models/aws_instance'
instance_ids = ARGV
instance_ids.each do |instance_id|
  instance_description = AwsInstance.new(instance_id).describe_instance
  binding.pry
end
