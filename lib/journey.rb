class Journey
  attr_reader :journey, :fare

  DEFAULT_FARE = 2

  def initialize
    @commute = true
    @fare = DEFAULT_FARE
  end

  def end_journey
    @commute = false
  end

  def commuting?
    !!@commute
  end

  def calculate_fare(entry_station, exit_station)
    @fare
  end
end
