class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_logged_user, only: [:orders, :line_items]

  # GET /users or /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  rescue_from 'User::Error' do |exception|
    redirect_to users_url, notice: exception.message
  end

  def orders
    @orders = @user.orders   
  end

  def line_items
    @page_number = params[:page] ? params[:page].to_i : 1
    @line_items = @user.line_items.limit(LINE_ITEMS_PER_PAGE).offset(LINE_ITEMS_PER_PAGE * (@page_number-1))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_logged_user
      @user = User.find_by(id: session[:user_id])
    end
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email)
    end
end
