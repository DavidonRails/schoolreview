class InstitutionsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    respond_to do |format|
      format.html do
        @institution = Institution.find(params[:id])
        @reviews = @institution.reviews
        @programs = @institution.programs.order("title").page(
                                             params[:page]).per(5)
      end

      format.json do
        @institution = Institution.find(params[:id])
        programs = @institution.programs
        render json: [programs]
      end
    end
  end

  def autocomplete
    render json: Institution.search(params[:search],
                                           autocomplete: false,
                                           limit: 10).map do |institution|
      { name: institution.title, value: institution.id }
    end
  end

  def index
    if params[:search].present?
      @institutions = Institution.search params[:search], page: params[:page], per_page: 20
    else
      @institutions = Institution.order("name").page(
                                                params[:page]).per(10)
    end
  end

  def new
    if current_user
      if current_user.admin == true
        @institution = Institution.new
      else
        flash[:error] = 'You need to be an admin to create a institution'
        redirect_to root_path
      end
    end
  end

  def create
  end
end
