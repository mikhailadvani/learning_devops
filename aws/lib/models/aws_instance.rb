class AwsInstance
  STATUS = {
      :PENDING => "pending",
      :RUNNING => "running",
      :SHUTTING_DOWN => "shutting-down",
      :TERMINATED => "terminated",
      :STOPPING => "stopping",
      :STOPPED => "stopped"
  }

  def initialize id=nil
    @ec2 = Aws::EC2::Client.new()
    @id = id
  end

  def create_instance instance_config, dry_run=true, tags=[]
    instance_config.merge!(min_count: 1, max_count: 1, dry_run: dry_run)
    begin
      response = @ec2.run_instances(instance_config)
      @id = response[:instances][0][:instance_id]
      puts "Instance created with id: #{@id}"
      add_tags tags
    rescue Aws::EC2::Errors::DryRunOperation
      puts "Dry run successful"
    rescue Exception => e
      puts "Execution unsuccessful: #{e.message}"
    end
  end

  def terminate_instance dry_run=true
    begin
      @ec2.terminate_instances({dry_run: dry_run, instance_ids: [@id]})
      puts "Instance terminated"
      @id= nil
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
    rescue Exception => e
      puts e.message
    end
  end

  def stop_instance
    begin
      @ec2.stop_instances({instance_ids: [@id]})
      wait_until :instance_stopped
    rescue Exception => e
      puts e.message
    end
  end

  def restart_instance
    self.stop_instance
    self.start_instance
  end

  def get_instance_status
    begin
      @ec2.describe_instances({instance_ids: [@id]})[:reservations][0][:instances][0][:state][:name]
    rescue Exception => e
      puts e.message
    end
  end

  private

  def add_tags tags
    @ec2.create_tags({resources: [@id], tags: tags}) unless tags.empty?
  end

  def wait_until state
    @ec2.wait_until(state, {instance_ids: [@id]})
  end

end

