# frozen_string_literal: true

class Report::Exporter
  ImportingError = Class.new(StandardError)

  def initialize(report:, data_source_uuid:)
    @report = report
    @data_source_uuid = data_source_uuid
    @external_customers = {}
    @external_plans = {}
  end

  def call!
    import_customers
    import_plans
    import_invoices
  rescue ChartMogul::ChartMogulError => error
    raise ImportingError, "There were problems during import:\n#{error.message}"
  end

  private

  attr_reader :report, :data_source_uuid, :external_customers, :external_plans

  def import_customers
    report.customers.each do |customer|
      external_customer = ChartMogul::Customer.all(external_id: customer.id).first

      if external_customer.nil?
        external_customer = ChartMogul::Customer.create!(
          data_source_uuid: data_source_uuid,
          external_id: customer.id,
          name: customer.name,
        )
      end

      external_customers[customer.id] = external_customer
    end
  end

  def import_plans
    report.plans.each do |plan|
      external_plan = ChartMogul::Plan.all(external_id: plan.id).first

      if external_plan.nil?
        external_plan = ChartMogul::Plan.create!(
          data_source_uuid: data_source_uuid,
          external_id: plan.id,
          name: plan.name,
          interval_count: plan.interval_count,
          interval_unit: plan.interval_unit,
        )
      end

      external_plans[plan.id] = external_plan
    end
  end

  def import_invoices
    report.invoices.each do |invoice|
      external_invoice = ChartMogul::Invoices.all(
        customer_uuid: external_customers[invoice.customer_id].uuid,
        external_id: invoice.id
      ).first

      if external_invoice.nil?
        exporte_invoice(invoice)
      end
    end
  end

  def exporte_invoice(invoice)
    line_item = build_line_item(invoice)
    external_invoice = build_external_invoice(invoice, line_item)
    ChartMogul::CustomerInvoices.create!(
      customer_uuid: external_customers[invoice.customer_id].uuid,
      invoices: [external_invoice]
    )
  end

  def build_line_item(invoice)
    ChartMogul::LineItems::Subscription.new(
      subscription_external_id: invoice.subscription_id,
      plan_uuid: external_plans[invoice.plan_id].uuid,
      service_period_start: invoice.period_start,
      service_period_end: invoice.period_end,
      amount_in_cents: invoice.amount_in_cents,
      tax_amount_in_cents: invoice.tax_amount_in_cents,
      quantity: 1,
    )
  end

  def build_external_invoice(invoice, line_item)
    ChartMogul::Invoice.new(
      external_id: invoice.id,
      currency: invoice.currency,
      date: invoice.date,
      line_items: [line_item],
    )
  end
end
