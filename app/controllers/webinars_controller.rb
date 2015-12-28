class WebinarsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_webinar, only: [:show, :edit, :update, :destroy]

  # GET /webinars
  # GET /webinars.json
  def index
    if current_user.admin
      @webinars = Webinar.all
    else
      @webinars = Webinar.where(:user_id => current_user.id)
    end
  end

  # GET /webinars/1
  # GET /webinars/1.json
  def show
    @webinar = Webinar.find(params[:id])
    # @webinar.filepath = "Big_Buck_Bunny.mp4"

  end

  # GET /webinars/new
  def new
    @webinar = Webinar.new
    @users = User.all
  end

  # GET /webinars/1/edit
  def edit
  end

  # POST /webinars
  # POST /webinars.json
  def create

    @webinar = Webinar.new
    @webinar.name = params[:webinar][:name]
    @webinar.participates = params[:webinar][:participates]
    @webinar.user_id = current_user.id
    @webinar.filepath = params[:webinar][:filepath]
    
    respond_to do |format|
      if @webinar.save
        format.html { redirect_to @webinar, notice: 'Webinar was successfully created.' }
        format.json { render :show, status: :created, location: @webinar }
        # render :json => @webinar, :notice => "Webinar was successfully created."
      else
        format.html { render :new }
        format.json { render json: @webinar.errors, status: :unprocessable_entity }
        # render :json => "Create Fail, try again"
      end
    end
  end

  # PATCH/PUT /webinars/1
  # PATCH/PUT /webinars/1.json
  def update
    respond_to do |format|
      if @webinar.update(update_params)

        format.html { redirect_to @webinar, notice: 'Webinar was successfully updated.' }
        format.json { render :show, status: :ok, location: @webinar }
      else
        format.html { render :edit }
        format.json { render json: @webinar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /webinars/1
  # DELETE /webinars/1.json
  def destroy
    @webinar.destroy
    respond_to do |format|
      format.html { redirect_to webinars_url, notice: 'Webinar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webinar
      @webinar = Webinar.find(params[:id])
    end

    def update_params
      params.require(:webinar).permit(:name, :filepath, :participates => [])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def webinar_params
      params.require(:webinar).permit(:name, :filepath, :participates, :user_id)
    end

end
