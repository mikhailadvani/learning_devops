require 'aws-sdk'
class ElasticIp
  def initialize dry_run=true
    @ec2 = Aws::EC2::Client.new()
    allocate dry_run
    @association_id = nil
  end

  def release
    begin
      @ec2.release_address({dry_run: false, allocation_id: @allocation_id})
      @public_ip = nil
      @association_id = nil
      @allocation_id = nil
      @ec2 = nil
    rescue Exception => e
      puts e.message
    end
  end

  def associate instance_id
    begin
      @association_id = @ec2.associate_address({dry_run: false, instance_id: instance_id, allocation_id: @allocation_id, allow_reassociation: true})[:association_id]
    rescue Exception => e
      puts e.message
    end
  end

  def dissociate
    begin
      @ec2.disassociate_address({dry_run: false, association_id: @association_id}) if self.associated?
    rescue Exception => e
      puts e.message
    end
  end

  def associated?
    self.associated_to ? true : false
  end

  def associated_to
    address_description = @ec2.describe_addresses({allocation_ids: [@allocation_id]})
    address_description[:addresses][0][:instance_id]
  end

  private
  def allocate dry_run
    begin
      response = @ec2.allocate_address({domain: "vpc", dry_run: dry_run})
      @public_ip = response[:public_ip]
      @allocation_id = response[:allocation_id]
    rescue Exception => e
      puts e.message
    end
  end
end