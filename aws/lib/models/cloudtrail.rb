class CloudTrail
  def initialize
    @cloudtrail = Aws::CloudTrail::Client.new()
  end

  def events
    @cloudtrail.lookup_events[:events]
  end
end