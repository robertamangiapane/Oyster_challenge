class Journey
  attr_reader :journeys, :commuting, :fare, :entry_station,
              :exit_station

  DEFAULT_FARE = 2

  def initialize
    @commuting = true
    @entry_station = ''
    @exit_station = ''
    @journeys = []
    @fare = DEFAULT_FARE
  end

  def add_journey(entry_station, exit_station)
    @journeys = [{ entry_station: entry_station, exit_station: exit_station }]
    @commuting = false
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    @commuting
  end

  def calculate_fare
    @fare
  end

end
