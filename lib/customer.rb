# frozen_string_literal: true

class Customer
  HEADER_CUSTOMER_ID = 'Customer ID'

  attr_reader :id, :name

  class << self
    def load_collection(table)
      table.entries.map do |entry|
        new(id: entry[HEADER_CUSTOMER_ID])
      end
    end
  end

  def initialize(id:, name: id)
    @id = id
    @name = name
  end
end
