# frozen_string_literal: true

class ExportsController < ApplicationController
  def index; end

  def invoices
    respond_to do |format|
      format.csv do
        csv = ::CsvExports::InvoiceExportService.new(Invoice.all.order(created_at: :desc).limit(250), 'index').to_csv
        send_data csv,
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: 'attachment',
                  filename: 'invoices.csv'
      end
    end
  end
end
