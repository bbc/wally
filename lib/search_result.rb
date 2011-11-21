class SearchResult
  attr_accessor :feature, :matched_feature, :matched_scenarios

  def initialize feature
    @feature = feature
    @matched_scenarios = []
  end

  def matches?
    return true if matched_feature
    return true unless matched_scenarios.empty?
    false
  end
end
