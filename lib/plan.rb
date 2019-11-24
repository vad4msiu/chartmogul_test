# frozen_string_literal: true

class Plan
  HEADER_PLAN_ID = 'Plan ID'
  HEADER_DURATION = 'Duration'
  INTERVAL_SPLITTER = ' '

  attr_reader :id, :name, :interval_count, :interval_unit

  class << self
    def load_collection(table)
      table.entries.map do |entry|
        interval_count, interval_unit = entry[HEADER_DURATION].
          split(INTERVAL_SPLITTER).
          map(&:strip)

        new(
          id: entry[HEADER_PLAN_ID],
          interval_count: interval_count.to_i,
          interval_unit: interval_unit,
        )
      end
    end
  end

  def initialize(id:, name: id, interval_count:, interval_unit:)
    @id = id
    @name = name
    @interval_count = interval_count
    @interval_unit = interval_unit
  end
end
