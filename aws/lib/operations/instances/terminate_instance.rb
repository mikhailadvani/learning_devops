require 'aws-sdk'
require 'pry'
require '../../../lib/models/aws_instance'
instance_id = ARGV[0]
AwsInstance.new(instance_id).terminate_instance dry_run=true