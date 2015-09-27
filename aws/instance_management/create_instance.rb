require 'aws-sdk'
require 'pry'
require 'json'
require 'rails'
template = JSON.parse(File.read("new_instance_template.json"),{:symbolize_names => true})
ec2 = Aws::EC2::Client.new()
response = ec2.run_instances(template)
puts "#{response[:instances].size} instances created:"
response[:instances].each do |instance|
  puts instance[:instance_id]
end