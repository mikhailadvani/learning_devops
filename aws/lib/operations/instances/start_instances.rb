require 'aws-sdk'
require 'pry'
require '../../../lib/models/aws_instance'
instance_ids = ARGV
instance_ids.each do |instance_id|
  AwsInstance.new(instance_id).start_instance
end
