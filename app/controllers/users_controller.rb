require 'quickblox'

class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    if params[:search].present?
      search = params[:search]
      n_page = params[:page]
      @users = User.search(search).order("last_name").page(n_page).per(9)
    else
      @users = User.order("last_name").page(params[:page]).per(10)
      respond_to do |format|
        format.html do
          @reviews = Review.order("updated_at").page(params[:page]).per(10)
          @users = User.order("last_name").page(params[:page]).per(10)
        end

        format.json do
          categories = []
          @users.each do |user|
            categories << "#{user.first_name} #{user.last_name}"
          end

          series = []

          Category.all.each do |category|
            new_series = Hash.new
            new_series[:name] = category.name

            new_series[:data] = []
            @users.each do |user|
              skill_list = user.skills.where(category_id: category.id)
              score = 0
              skill_list.each do |skill|
                score = score + skill.points
              end
              new_series[:data] << score
            end
            series << new_series
          end

          render json: [categories, series]
        end
      end
    end

    @webinars = Webinar.order("created_at DESC").limit(4)

    @paticipants_list = []

    @webinars.each do |webinar|
      participates = webinar.participates
      pat_list = []

      participates.each do |pat|
        if pat != ''
          pat_list << User.where(:id => pat.to_i)
        end
      end
      @paticipants_list << pat_list

    end

    @programs_list = []

    Institution.all.each do |institution|
      new_series = Hash.new

      new_series[:name] = institution.name
      new_series[:data] = []

      Program.where(:institution => institution).each do |ins_p|
        new_series[:data] << ins_p.title
      end

      @programs_list << new_series
    end

  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(5)
    @skills = @user.skills
    @programs = @user.user_program_attendancies
    @skill = Skill.new
    @program = Program.new
    @user_program_attendancy = UserProgramAttendancy.new
    @programs_finished = @user.user_program_attendancies.where('end_date < ?',
                                                               Time.now)
    @programs_planning = @user.user_program_attendancies.where(
                                                              'start_date > ?',
                                                              Time.now)
    @programs_inprogress =
    @user.user_program_attendancies.where('start_date < ? AND end_date > ?',
                                          Time.now, Time.now)

    respond_to do |format|
      format.html do
        @user = User.find(params[:id])
        @reviews = @user.reviews.page(params[:page]).per(5)
      end

      format.json do
        @user = User.find(params[:id])
        @skills = @user.skills
        @category_list = []
        @skill_points_output = Hash.new
        @skills.each do |skill|
          category_name = Category.find(skill[:category_id]).name
          if @skill_points_output.has_key?(category_name) == false
            @skill_points_output["#{category_name}"] = skill[:points]
          else
            @skill_points_output["#{category_name}"] = @skill_points_output["#{category_name}"] +
            skill[:points]
          end
        end
        user_skill_output = @skill_points_output
        timeline_output = []
        @user.user_program_attendancies.each do |user_program_attendancy|
          timeline_output << [user_program_attendancy, user_program_attendancy.user, user_program_attendancy.program]
        end
        user_description = @user.description

        # The json object 'user_skill_output' is for the web-map js.
        # The json object 'timeline_output' is for the timeline js.
        # The json object 'skills_output' is for the web-user-skills
        render json: [user_skill_output, timeline_output, user_description]
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    if !@user.access_privilege(current_user)
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Successfully updated!'
      redirect_to user_path(@user)
    else
      flash[:alert] = 'Something went wrong!'
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user = current_user
      @user.destroy
      flash[:success] = 'User deleted'
      redirect_to root_path
    else
      flash[:alert] = 'You don\'t have the permission'
      redirect_to user_path current_user
    end
  end

  def program_search
    @result = []
    key = params[:program]

    program = Program.where("lower(title) like lower (?)","#{key}")
    
    user_program_attendancies = UserProgramAttendancy.where(:program_id => program[0].id)

    user_ids = []
    programs = []

    user_program_attendancies.each do |user_program_attendancy|
      
      if !(user_ids.include?(user_program_attendancy.user_id))
        user_ids << user_program_attendancy.user_id
      end
    end
    
    user_ids.each do |user_id|
      search_temp = Hash.new

      user_temp = User.find_by_id(user_id)
      
      program_output = []

      user_temp.user_program_attendancies.each do |user_program_attendancy|
        program_output << [user_program_attendancy, user_program_attendancy.program, user_program_attendancy.program.institution]
      end

      search_temp[:user] = user_temp
      search_temp[:programs] = program_output
      @result << search_temp
    end

    render :json => @result, :status => 200
    
  end

  def desc_search
    @result = []
    key = params[:description]

    users = []
    programs = []

    users = User.where("lower(description) like lower(?)", "%#{key}%")

    users.each do | u |
      search_temp = Hash.new
      
      program_output = []

      u.user_program_attendancies.each do |user_program_attendancy|
        program_output << [user_program_attendancy, user_program_attendancy.program, user_program_attendancy.program.institution]
      end

      search_temp[:user] = u
      search_temp[:programs] = program_output
      @result << search_temp
    end

    render :json => @result, :status => 200

  end

  def name_search
    @result = []
    keys = params[:username].split

    users = []
    programs = []

    if keys.length > 1 
      users = User.where("lower(first_name) like lower(?) and lower(last_name) like lower(?) ", "%#{keys[0]}%", "%#{keys[2]}%")
    else 
      users = User.where("lower(first_name) like lower(?) OR lower(last_name) like lower(?) ", "%#{keys[0]}%", "%#{keys[0]}%")
    end

    users.each do | u |
      search_temp = Hash.new
      
      program_output = []

      u.user_program_attendancies.each do |user_program_attendancy|
        program_output << [user_program_attendancy, user_program_attendancy.program, user_program_attendancy.program.institution]
      end

      search_temp[:user] = u
      search_temp[:programs] = program_output
      @result << search_temp
    end

    render :json => @result, :status => 200
  end

  def location_search
    @result = []
    key = params[:location]

    users = []
    programs = []

    users = User.where("lower(location) like lower(?)", "%#{key}%")

    users.each do | u |
      search_temp = Hash.new
      
      program_output = []

      u.user_program_attendancies.each do |user_program_attendancy|
        program_output << [user_program_attendancy, user_program_attendancy.program, user_program_attendancy.program.institution]
      end

      search_temp[:user] = u
      search_temp[:programs] = program_output
      @result << search_temp
    end

    render :json => @result, :status => 200
  end

  protected

  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :location,
      :profile_photo,
      :description
    )
  end
end
