class UsersController < Clearance::UsersController
  def user_params
    params[:user].permit(:email, :password, :first_name, :last_name)
  end
end
