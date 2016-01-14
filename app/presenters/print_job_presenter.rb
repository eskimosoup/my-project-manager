class PrintJobPresenter < BasePresenter
  presents :print_job
  delegate :name, :brand_price, :brand_rush_job_price, to: :print_job

  def link
    print_job
  end

  def linked_content(content = 'View', options = {})
    h.link_to content, link, options
  end

  def delete_job
    h.button_to "Remove", print_job, method: :delete,
      data: { confirm: "Are you sure?", disable_with: "Processing" }, class: 'secondary-action-button delete-job'
    end

  def brand_price_currency
    h.number_to_currency brand_price
  end

  def brand_rush_job_price_currency
    h.number_to_currency brand_rush_job_price
  end
end
