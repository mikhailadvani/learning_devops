class AwsInstance
  def initialize id=nil
    @ec2 = Aws::EC2::Client.new()
    @id = id
  end

  def create_instance instance_config, dry_run=true
    instance_config.merge!(min_count: 1, max_count: 1, dry_run: dry_run)
    begin
      response = @ec2.run_instances(instance_config)
      @id = response[:instances][0][:instance_id]
      puts "Instance created with id: #{@id}"
    rescue Aws::EC2::Errors::DryRunOperation
      puts "Dry run successful"
    rescue Exception => e
      puts "Execution unsuccessful: #{e.message}"
    end
  end

  def start_instance
    begin
      @ec2.start_instances({instance_ids: [@id]})
      wait_until :instance_running
    rescue Aws::EC2::Errors::InvalidInstanceIDNotFound => invalidIdException
      puts invalidIdException.message
    rescue Exception => e
      puts e.message
    end
  end

  def stop_instance
    begin
      @ec2.stop_instances({instance_ids: [@id]})
      wait_until :instance_stopped
    rescue Aws::EC2::Errors::InvalidInstanceIDNotFound => invalidIdException
      puts invalidIdException.message
    rescue Exception => e
      puts e.message
    end
  end

  def wait_until state
    @ec2.wait_until(state, {instance_ids: [@id]})
  end

end

