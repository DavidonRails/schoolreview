class SkillsController < ApplicationController
  before_filter :authenticate_user!
  def create
    @skill = Skill.new(skill_params)
    @user = User.find(params[:user_id])
    @skill.user = @user

    if @skill.save
      flash[:success] = "skill successfully created!"
      redirect_to user_path @user
    else
      flash[:warning] = @skill.errors.full_messages.join(". ")
      redirect_to user_path @user
    end
  end

  protected

  def skill_params
    params.require(:skill).permit(
      :name,
      :description,
      :points,
      :program_id,
      :user_id,
      :category_id
    )
  end
end
