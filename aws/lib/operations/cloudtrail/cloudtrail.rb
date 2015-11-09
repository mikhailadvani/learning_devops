require 'aws-sdk'
require 'pry'
require 'json'
require 'rails'
require '../../../lib/models/cloudtrail'
cloudtrail = CloudTrail.new()
events = cloudtrail.events
events.each do |event|
  event_time = event[:event_time]
  event_name = event[:event_name]
  username = event[:username]
  resources = event[:resources] || "nil"
  error_code = JSON.parse(event[:cloud_trail_event])["errorCode"] || "nil"
  puts "event_time=#{event_time} event_name=#{event_name} username=#{username} error_code=#{error_code} resources=#{resources}"
end
