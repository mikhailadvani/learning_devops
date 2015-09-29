require 'pry'
require '../../../lib/models/elastic_ip'

ip = ElasticIp.new(dry_run=false)
puts "IP associated: #{ip.associated?}"
puts "IP associated to: #{ip.associated_to}"
ip.associate(ARGV[0])
puts "IP associated: #{ip.associated?}"
puts "IP associated to: #{ip.associated_to}"
ip.dissociate
puts "IP associated: #{ip.associated?}"
puts "IP associated to: #{ip.associated_to}"
ip.release