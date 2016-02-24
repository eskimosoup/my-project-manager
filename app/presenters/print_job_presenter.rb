class PrintJobPresenter < BasePresenter
  presents :print_job
  delegate :name, :rush_job?, :brand_price, :brand_rush_job_price, to: :print_job

  def path
    h.print_job_path(print_job)
  end

  def linked_content(content = 'View', options = {})
    h.link_to content, path, options
  end

  def octicon_view_link
    linked_content(octicon_view_content, class: 'print-job-view-link')
  end

  def delete_link
    h.button_to 'Remove', print_job, method: :delete,
                                     data: { confirm: 'Are you sure?', disable_with: 'Processing' }, class: 'action-button delete-job'
    end

  def brand_price_currency
    h.number_to_currency brand_price
  end

  def brand_price_profit_currency
    # TODO: ?
    h.number_to_currency print_job.brand_price_profit
  end

  def envisage_price_currency
    # TODO: ?
    h.number_to_currency print_job.envisage_price
  end

  def envisage_profit_currency
    # TODO: ?
    h.number_to_currency print_job.envisage_profit
  end

  def job_type
    if rush_job?
      'Rush Job'
    else
      'Standard'
    end
  end

  private

  def octicon_view_content
    [octicon('eye'), name].join(' ').html_safe
  end
end
