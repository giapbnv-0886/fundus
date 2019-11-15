class Cadmin::UsersController < Cadmin::BasesController
  before_action :get_user, only: %i(edit destroy show update)

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to cadmin_user_path @user
    else
      flash[:danger] = "Create fail"
    end
  end

  def edit; end

  def update
     @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = "success"
      redirect_to cadmin_user_path @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Deleted"
      redirect_to cadmin_users_path
    else
      flash[:danger] = "Delete failed"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit :id, :name, :email, :password, :password_confirmation, :role
  end

  def get_user
    @user = User.find_by id: params[:id]
    redirect_to cadmin_users_path unless @user
  end
end
