class Admin::ArticlesController < Admin::AdminController
  
  ## manual authorization
  before_filter do |controller|
    controller.check_roles(["admin", "article_writer"])
  end
  
  ## CanCan authorization - see Ability model
  authorize_resource
  
  def index
    @categories = Category.all
    @articles = Article.all
    @admin_editing_language = admin_editing_language
  end
  
  def new
    @categories = Category.all
    @article = current_user.articles.new
    @admin_editing_language = admin_editing_language
  end
  
  def create
    @categories = Category.all
    @article = current_user.articles.new(params[:article])
    @article.pretty_url = @article.pretty_url.urlify.blank? ? @article.title.urlify : @article.pretty_url.urlify
    @article.publish_at = Time.now if @article.published
    
    
    if @article && @article.save && @article.errors.empty?
      redirect_to admin_articles_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @admin_editing_language = admin_editing_language
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    @article.attributes = params[:article] unless @article.blank?
    @article.pretty_url = @article.pretty_url.urlify.blank? ? @article.title.urlify : @article.pretty_url.urlify
    @article.publish_at = Time.now if @article.published
    if @article && @article.save && @article.errors.empty?
      redirect_to admin_articles_path
    else
      render :action => "edit"
    end
  end
  
end