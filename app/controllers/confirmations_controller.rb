require 'quickblox'

class ConfirmationsController < Devise::ConfirmationsController

  def new
    super
  end

  def create
    super
  end

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

  private

  def after_confirmation_path_for(resource_name, resource)

    $qb = Quickblox.new
 	
   	user_params = {"user[login]" => resource.email, "user[password]" => "quickblox_common_password", "user[email]" => resource.email, "user[full_name]" => resource.first_name << " " << resource.last_name }
    @resp = $qb.signup_user(user_params)

    if(@resp[:response_body]['errors'])
      flash[:alert] = "Your account has some issue with Quickblox! Please try contact to admin!"
      new_user_session_path
    else
      @id = @resp[:response_body]['user']['id']

      resource.qb_id = @id #quickblox id is saved

      resource.save

      if signed_in?(resource_name)
        root_path
      else
        new_user_session_path
      end
    end

  end
end