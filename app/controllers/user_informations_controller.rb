class UserInformationsController < ApplicationController
  def new
    @user_info = UserInformation.new
  end

  def create
    @user_info = UserInformation.new(params_user)
    @user_info.first_name = @user_info.first_name.titleize
    @user_info.middle_name = @user_info.middle_name.titleize
    @user_info.last_name = @user_info.last_name.titleize
    @user_info.country = @user_info.country.titleize
    @user_info.state = @user_info.state.titleize
    @user_info.city = @user_info.city.titleize
    @user_info.religion = @user_info.religion.titleize
    @user_info.gender = @user_info.gender.titleize
    @user_info.user_id = current_user.id
    if @user_info.save
      flash[:success] = "User Profile Created."
      redirect_to :authenticated_root
    else
      flash[:error] = "Unable to create User Profile."
      render "new"
    end
  end

  def edit
    @user_info = UserInformation.find_by_user_id(current_user.id)
  end

  def update
    @user_info = UserInformation.find_by_user_id(current_user.id)
    if @user_info.update(params_user)
      flash[:success] = "User Profile Created."
      redirect_to :authenticated_root
    else
      flash[:error] = "Unable to create User Profile."
      render "new"
    end
  end

  private

  def params_user
    params.require(:user_information).permit(:first_name,:middle_name,:last_name,:country,:state,:photo,:phone_no,:city,:religion,:dob,:gender)
  end
end
