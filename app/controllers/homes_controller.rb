class HomesController < ApplicationController
  skip_before_action :require_login, only: :show

  def show
  end

  def finances
  end
end
