class TopicsController < ApplicationController
  add_breadcrumb "Home", :authenticated_root_path
  add_breadcrumb "Topics", :topics_path
  def new
    @title = "Add"
    add_breadcrumb "New"
    @topic = Topic.new
    @category_list = Category.where("user_id =?", current_user.id).select(:name, :id).order("name ASC")
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    @category_list = Category.where("user_id =?", current_user.id).select(:name, :id).order("name ASC")
    if @topic.save
      flash[:success] = "Topic created."
      redirect_to :new_topic
    else
      flash[:error] = "Unable to create topic."
      render :new
    end
  end

  def edit
    @title = "Edit"
    add_breadcrumb "Edit"
    @topic = Topic.find(params[:id])
    @category_list = Category.where("user_id =?", current_user.id).select(:name, :id).order("name ASC")
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      flash[:success] = "Topic Updated."
      redirect_to "/topics/" + @topic.category.id.to_s
    else
      flash[:error] = "Unable to update topic."
      @category_list = Category.where("user_id =?", current_user.id).select(:name, :id).order("name ASC")
      render :edit
    end
  end

  def destroy
    @topic = Topic.destroy(params[:id])
    if @topic.destroyed?
      flash[:success] = "#{@topic.name} destroyed."
    else
      flash[:error] = "Unable to destroy #{@topic.name}"
    end
    redirect_to "/topics/" + @topic.category.id.to_s
  end

  def index #topic
    @title = "List"
    @category = Category.where("user_id =?", current_user.id).select(:name, :id).order("name ASC")
  end

  def supply_topic
    @topic = Topic.search(params[:id], params[:search], current_user.id)
    render json: @topic
  end

  def show #category -> topic
    @title = "Topics"
    add_breadcrumb "List"
    @perpage = 12

    @topics = Topic.search(params[:id], params[:search], current_user.id)
    @topic = @topics.paginate(:page => params[:page], :per_page => @perpage)
    @page = params[:page] || 1
  end

  def fav_topic #fav_category -> fav_topic
    @title = "Favourite | List"
    add_breadcrumb "Favourite"
    @perpage = 1
    @topics = Topic.fav_search(params[:id], params[:search], current_user.id)
    @topic = @topics.paginate(:page => params[:page], :per_page => @perpage)
    @page = params[:page] || 1
  end

  def link_topic #total fav topics
    @title = "Favorite | List"
    add_breadcrumb "Favorite"
    @topics = Topic.fav_search_all(params[:search],current_user.id)
    @perpage = 12
    @topic = @topics.paginate(:page => params[:page], :per_page => @perpage)
  end

  def update_fav_topic
    @topic = Topic.find(params[:id])
    if @topic.favorite.present?
      @topic.favorite = false
      printf "topic: #{@topic.favorite}"
    else
      @topic.favorite = true
    end
    @topic.save
    render json: @topic.favorite
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :category_id, :favorite)
  end
end
