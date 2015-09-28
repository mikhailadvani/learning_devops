require 'aws-sdk'
require 'pry'
require '../../../aws/instance_management/models/aws_instance'
instance_id = ARGV[0]
AwsInstance.new(instance_id).terminate_instance dry_run=true