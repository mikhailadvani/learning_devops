require 'aws-sdk'
require 'pry'
require '../../aws/instance_management/aws_instance'
instance_ids = ARGV
instance_ids.each do |instance_id|
  AwsInstance.new(instance_id).terminate_instance dry_run=false
end
