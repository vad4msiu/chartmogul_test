# frozen_string_literal: true

module Order::Packer
  module_function

  def pack(target:, capacities:)
    return nil if target < 0

    parents = Array.new(target + 1)
    parents[0] = 0
    work_capacities = [[0, 0]]

    while parents[target].nil? && !work_capacities.empty? do
      base, starting_index = work_capacities.shift
      starting_index.upto(capacities.size - 1) do |index|
        coin = capacities[index]
        tot = base + coin

        if tot <= target && parents[tot].nil?
          parents[tot] = base
          work_capacities << [tot, index]
        end
      end
    end

    return nil if parents[target].nil?

    result = []
    while target > 0 do
      parent = parents[target]
      result << target - parent
      target = parent
    end

    result.sort!.reverse!
   end
end
