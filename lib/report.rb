# frozen_string_literal: true

class Report
  attr_reader :table

  class << self
    def load(report_path)
      table = CSV.read(report_path, headers: true, return_headers: false)
      new(table: table)
    end
  end

  def initialize(table:)
    @table = table
  end

  def customers
    @customers ||= Customer.load_collection(table).uniq(&:id)
  end

  def plans
    @plans = Plan.load_collection(table).uniq(&:id)
  end

  def invoices
    @invoices = Invoice.load_collection(table)
  end

  def +(report)
    rows = table.entries + report.table.entries
    table = CSV::Table.new(rows)
    self.class.new(table: table)
  end
end
