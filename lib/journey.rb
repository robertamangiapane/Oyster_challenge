class Journey
  attr_reader :journey, :fare, :entry_station,
              :exit_station

  DEFAULT_FARE = 2

  def initialize
    @entry_station = ''
    @exit_station = ''
    @fare = DEFAULT_FARE
  end

  def end_journey
    @entry_station = nil
    @exit_station = nil
  end

  def commuting?
    !!@exit_station
  end

  def calculate_fare
    @fare
  end
end
