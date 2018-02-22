class Connection
  attr_reader :from, :to, :weight

  def initialize(from, to, weight = rand(-1..1.0))
    @from = from
    @to = to
    @weight = weight
  end

  def adjust_weight(delta)
    @weight += delta
  end
end
