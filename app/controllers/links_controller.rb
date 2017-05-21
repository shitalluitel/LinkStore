class LinksController < ApplicationController
  add_breadcrumb "Home", :authenticated_root_path
  def new
    @title = "Add"
    add_breadcrumb "Links / New"
    @link = Link.new
    @category_list = Category.where("user_id =? ", current_user.id).select(:name, :id).order("name ASC")
  end

  def create
    @link =Link.new(link_params)
    @link.user_id = current_user.id
    @category_list = Category.where("user_id =? ", current_user.id).select(:name, :id).order("name ASC")
    if @link.save
      flash[:success] = "Link added."
      redirect_to :new_link
    else
      flash[:error] = "Couldn't add link."
      render :new
    end
  end

  def edit
    @title = "Edit"
    add_breadcrumb "Links / Edit"
    @link = Link.find(params[:id])
    @topic = @link.topic_id
    @category_list = Category.where("user_id =?", current_user.id).select(:name, :id).order("name ASC")
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:success] = "Link added."
      redirect_to "/links/" + @link.topic.id.to_s
    else
      flash[:error] = "Couldn't add link."
      render :edit
    end
  end

  def show
    @title = "Links"
    add_breadcrumb "List"
    @link = Link.supply_links(params[:id],current_user.id, params[:search])
    @perpage = 12
    @links = @link.paginate(:page => params[:page], :per_page => @perpage)
  end

  def index
    @title = "List"
    @category_list = Category.where("user_id =?", current_user.id).select(:name, :id).order("name ASC")
  end

  def destroy
    @link = Link.destroy(params[:id])
    if @link.destroyed?
      flash[:success] = "Link Destroyed."
    else
      flash[:alert] = "Unable To Destroy Link."
    end
    @category_list = Category.where("user_id =?", current_user.id).select(:name, :id).order("name ASC")
  end

  def get_link
    @topic = Link.supply_links(params[:id], current_user.id, params[:search])
    render json: @topic
  end

  def fav_link
    @title = "Links"
    add_breadcrumb "List"
    @link = Link.search(params[:id],current_user.id, params[:search])
    @perpage = 12
    @links = @link.paginate(:page => params[:page], :per_page => @perpage)
  end

  def fav_link_all
    @title = "Favorite | List"
    add_breadcrumb "Favorite"
    @link = Link.fav_search_all(params[:search],current_user.id)
    @perpage = 12
    @links = @link.paginate(:page => params[:page], :per_page => @perpage)
  end

  def update_fav_link
    @link = Link.find(params[:id])
    if @link.favorite.present?
      @link.favorite = false
    else
      @link.favorite = true
    end
    @link.save
    render json: @link.favorite
  end

  private

  def link_params
    params.require(:link).permit(:topic_id,:name, :link,:category_id, :favorite,:description)
  end
end
