class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :set_article, except: [:index,:new, :create, :buscar]

  def buscar
    @buscar = false
  end
  #GET article
  def index
    palabra = "%#{params[:keyword]}%"
    if palabra!=nil
      @articles = Article.where("title LIKE ? OR artista LIKE ? OR album LIKE ?",palabra,palabra,palabra)
    else
      @articles = Article.all.recientes
    end
  end

  #GET /articles/:id
  def show
    @article.update_visits_count
  end
  #GET /articles/new
  def new
    @article = Article.new
  end


  def edit

  end

  def update

    if  @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end
  def destroy

    @article.destroy
    redirect_to articles_path
  end


  #POST /articles
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end
  private
  def set_article
      @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:body,:tamano,:artista,:ano,:tiempo,:album,:privacida,:mp3)
  end
end
