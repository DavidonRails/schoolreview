class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @institution = Institution.find(params[:institution_id])
    @reviews = @institution.reviews
    @user = current_user
  end

  def edit
    review = Review.find(params[:id])
    if signed_in? && (current_user == review.user || current_user.admin)
      @institution = Institution.find(params[:institution_id])
      @program = Program.find(params[:program_id])
      @review = Review.find(params[:id])
    else
      flash[:alert] = 'You have to sign in first'
      redirect_to institutions_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @institution = Institution.find(params[:institution_id])
    @program = Program.find(params[:program_id])
    if signed_in? && (current_user == @review.user || current_user.admin)
      if @review.update_attributes(review_params)
        flash[:notice] = 'Review successfully updated'
        redirect_to institution_program_path(@institution, @program)
      else
        flash[:error] = @review.errors.full_messages.join(', ')
        render :edit
      end
    else
      flash[:alert] = 'You have no permission to edit this review'
      redirect_to institution_path @institution
    end
  end

  def new
    if user_signed_in?
      @institution = Institution.find(params[:institution_id])
      @program = Program.find(params[:program_id])
      @review = Review.new
    else
      flash[:error] = 'Please log in or sign up first'
      redirect_to institutions_path
    end
  end

  def show
    @institution = Institution.find(params[:institution_id])
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @institution = Institution.find(params[:institution_id])
    @program = Program.find(params[:program_id])
    @review.institution = @institution
    @review.user = current_user
    @review.program = @program

    if @review.save
      flash[:success] = "review successfully created!"
      redirect_to institution_program_path(@institution, @program)
    else
      flash[:error] = @review.errors.full_messages.join(". ")
      render :new
    end
  end

  def upvote
    @review = Review.find(params[:id])
    @institution = Institution.find(params[:institution_id])

    respond_to do |format|
      format.json do
        if current_user
          @review.upvote_by current_user
          rating = @review.score
          review = @review
          valid = true
          render json: [review, rating, valid]
        else
          rating = @review.score
          review = @review
          valid = false
          render json: [review, rating, valid]
        end
      end
    end
  end

  def downvote
    @review = Review.find(params[:id])
    @institution = Institution.find(params[:institution_id])

    respond_to do |format|
      format.json do
        if current_user
          @review.downvote_by current_user
          review = @review
          rating = @review.score
          valid = true
          render json: [review, rating, valid]
        else
          rating = @review.score
          review = @review
          valid = false
          render json: [review, rating, valid]
        end
      end
    end
  end

  def destroy
    @institution = Institution.find(params[:institution_id])
    @review = Review.find(params[:id])
    if signed_in? && (current_user == @review.user || current_user.admin)
      @review.destroy
      flash[:success] = 'review successfully deleted!'
      redirect_to institution_path @institution
    else
      flash[:alert] = 'You have no permission to delete this review'
      redirect_to institution_path @institution
    end
  end

  protected
  def review_params
    params.require(:review).permit(:content, :rating, :institution_id, :user_id, :title, :rating)
  end
end
