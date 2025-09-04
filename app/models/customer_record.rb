class CustomerRecord
  attr_reader :user_id, :name, :latitude, :longitude

  def initialize(user_id:, name:, latitude:, longitude:)
    @user_id   = Integer(user_id)
    @name      = String(name)
    @latitude  = Float(latitude)
    @longitude = Float(longitude)
  end

  def self.from_json_line(line)
    data = Oj.load(line, mode: :compat)
    new(
      user_id: data.fetch("user_id"),
      name: data.fetch("name"),
      latitude: data.fetch("latitude"),
      longitude: data.fetch("longitude")
    )
  rescue KeyError, ArgumentError, TypeError => e
    raise ArgumentError, "Invalid line: #{e.message}"
  end
end
