class CategoriesController < ApplicationController
  add_breadcrumb "Home", :authenticated_root_path
  def new
    @title = "Add"
    add_breadcrumb "New"
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.name = @category.name.titleize
    @category.user_id = current_user.id
    if @category.save
      flash[:success] = "Category Created."
      redirect_to :categories
    else
      flash[:error] = "Unable to create Category."
      render "new"
    end
  end

  def edit
    @title = "Edit"
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Category Updated."
      redirect_to :categories
    else
      flash[:error] = "unable to update category."
      render "edit"
    end
  end

  def destroy
    @category = Category.destroy(params[:id])
    if @category.destroyed?
      flash[:success] = "Category Deleted."
    else
      flash[:error] = "Unable to delete category."
    end
    redirect_to :categories
  end

  def index
    @check_title = "Catatogy"
    @title = "List"
    @perpage = 12
    @category = Category.search(params[:search], current_user.id)
    @categories = @category.paginate(:page => params[:page], :per_page => @perpage)
  end

  def fav_category
    @check_title = "Catatogy"
    @title = "List"
    @perpage = 12
    @category = Category.fav_search(params[:search], current_user.id)
    @categories = @category.paginate(:page => params[:page], :per_page => @perpage)
  end

  def update_fav_category
    @category = Category.find(params[:id])
    if @category.favorite.present?
      @category.favorite = false
    else
      @category.favorite = true
    end
    @category.save
    render json: @category.favorite
  end

  private

  def category_params
    params.require(:category).permit(:name, :description,:favorite)
  end
end
