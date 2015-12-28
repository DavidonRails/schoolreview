class UserProgramAttendanciesController < ApplicationController
  before_filter :authenticate_user!
  def create
    @user_program_attendancy = UserProgramAttendancy.new(input_params)
    @user_program_attendancy.user = current_user

    if @user_program_attendancy.save
      flash[:success] = "successfully added your program"
      redirect_to user_path current_user
    else
      flash[:alert] = @user_program_attendancy.errors.full_messages.join(". ")
      redirect_to user_path current_user
    end
  end

  def index
    @user_program_attendancies = current_user.user_program_attendancies
  end

  def edit
    @user_program_attendancy = UserProgramAttendancy.find(params[:id])
  end

  def update
    @user_program_attendancy = UserProgramAttendancy.find(params[:id])
    if @user_program_attendancy.update_attributes(input_params)
      flash[:success] = 'Successfully updated!'
      redirect_to user_program_attendancies_path
    else
      flash[:alert] = 'Something went wrong!'
      render 'edit'
    end
  end

  def destroy
    @user_program_attendancy = UserProgramAttendancy.find(params[:id])
    if @user_program_attendancy.user = current_user
      @user_program_attendancy.destroy
      flash[:success] = 'Program successfully deleted'
      redirect_to user_program_attendancies_path
    else
      flash[:alert] = 'You don\'t have permission'
      redirect_to user_program_attendancies_path
    end
  end

  protected

  def input_params
    params.require(:user_program_attendancy).permit(
      :program_id,
      :user_id,
      :start_date,
      :end_date,
      :url
    )
  end
end
