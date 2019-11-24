# frozen_string_literal: true

class Invoice
  HEADER_SUBSCRIPTION_ID = 'Subscription ID'
  HEADER_AMOUNT = 'Amount'
  HEADER_TAX = 'Tax'
  HEADER_CURRENCY = 'Currency'
  HEADER_PERIOD_START = 'Period Start'
  HEADER_PERIOD_END = 'Period End'
  HEADER_DURATION = 'Duration'

  attr_reader(
    :customer_id,
    :subscription_id,
    :amount_in_cents,
    :tax_amount_in_cents,
    :currency,
    :period_start,
    :period_end,
    :plan_id,
    :duration,
    :date,
  )

  class << self
    def load_collection(table)
      date = Date.today
      table.entries.map do |entry|
        new(
          customer_id: entry[Customer::HEADER_CUSTOMER_ID],
          subscription_id: entry[HEADER_SUBSCRIPTION_ID],
          amount_in_cents: convert_dollars_to_cents(entry[HEADER_AMOUNT]),
          tax_amount_in_cents: convert_dollars_to_cents(entry[HEADER_TAX]),
          currency: entry[HEADER_CURRENCY],
          period_start: entry[HEADER_PERIOD_START],
          period_end: entry[HEADER_PERIOD_END],
          plan_id: entry[Plan::HEADER_PLAN_ID],
          duration: entry[HEADER_DURATION],
          date: date,
        )
      end
    end

    private

    def convert_dollars_to_cents(amount)
      (amount.to_f * 100).to_i
    end
  end

  def initialize(
    customer_id:,
    subscription_id:,
    amount_in_cents:,
    tax_amount_in_cents:,
    currency:,
    period_start:,
    period_end:,
    plan_id:,
    duration:,
    date:
  )
    @customer_id = customer_id
    @subscription_id = subscription_id
    @amount_in_cents = amount_in_cents
    @tax_amount_in_cents = tax_amount_in_cents
    @currency = currency
    @period_start = period_start
    @period_end = period_end
    @plan_id = plan_id
    @duration = duration
    @date = date
  end

  def id
    Digest::MD5.hexdigest(
      [
        customer_id,
        subscription_id,
        amount_in_cents,
        tax_amount_in_cents,
        currency,
        period_start,
        period_end,
        plan_id,
        duration,
      ].to_s
    )
  end
end
