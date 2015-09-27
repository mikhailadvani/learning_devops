class AwsInstance
  def initialize (id)
    @ec2 = Aws::EC2::Client.new()
    @id = id
  end

  def start_instance
    resp = @ec2.start_instances({instance_ids: [@id]})
    wait_until :instance_running
    resp
  end

  def stop_instance
    resp = @ec2.stop_instances({instance_ids: [@id]})
    wait_until :instance_stopped
    resp
  end

  def wait_until state
    @ec2.wait_until(state, {instance_ids: [@id]})
  end

end

