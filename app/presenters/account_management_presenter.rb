class AccountManagementPresenter < BasePresenter
  presents :account_management
  delegate :hours, to: :account_management

  def edit_link_content(content = 'Edit', options = {})
    h.link_to content, edit_link, options
  end

  def edit_link
    h.edit_account_management_path(account_management)
  end

  def time
    h.pluralize(hours, "hour")
  end

  def delete_link
    h.button_to 'Remove', account_management, method: :delete,
                data: { confirm: 'Are you sure?', disable_with: 'processing...' }, class: 'secondary-action-button'
  end
end
