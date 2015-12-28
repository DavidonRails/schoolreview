class ProgramsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @program = Program.find(params[:id])
    @institution = @program.institution
    @reviews = @program.reviews
  end

  def index
    if params[:search].present?
      @programs = Program.search params[:search], page: params[:page], per_page: 20
    else
      @programs = Program.order("title").page(params[:page]).per(10)
    end
  end
end
