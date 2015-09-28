require 'aws-sdk'
require 'pry'
require 'json'
require 'rails'
require '../../aws/instance_management/aws_instance'
template = JSON.parse(File.read("new_instance_template.json"), {:symbolize_names => true})
instance = AwsInstance.new()
instance.create_instance(template, dry_run=true, [
    {
        key: "ScriptExec",
        value: "1"
    }
])