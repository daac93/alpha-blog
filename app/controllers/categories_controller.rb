class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    before_action :set_category, only: [:edit, :update]
    
    def index
        @categories = Category.paginate(page: params[:page], per_page: 3)
    end
    
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category was successfully created"
            redirect_to categories_path
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @category.update(category_params)
            flash[:success] = "Name was successfully updated"
            redirect_to category_path(@category)
        else
            render 'edit'
        end
    end
    
    def show
        @category = Category.find(params[:id])
        @category_articles = @category.articles.paginate(page: params[:page], per_page: 3)
    end
    
    private
    def category_params
        params.require(:category).permit(:name)
    end
    
    def require_admin
       if !logged_in? || (logged_in? && !current_user.admin?)
          flash[:danger] = "Only admins can perform that action"
          redirect_to categories_path
       end
    end
    
    def set_category
        @category = Category.find(params[:id])
    end
end