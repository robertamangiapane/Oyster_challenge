class Station
  attr_reader :zone
  def initialize(zone)
    @zone = zone
  end
end

# Samples
aldgate = Station.new("1")
stratford = Station.new("3")
morden = Station.new("4")
liverpool_st = Station.new("1")
