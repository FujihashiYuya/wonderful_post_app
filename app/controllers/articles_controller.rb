class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = Article.all
  end
  def show
  end
  def edit
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "記事を作成しました"
    else
      render :new
    end
  end
  def update
    if @article.update(article_params)
      redirect_to article_url(article_params), notice: "記事を編集しました"
    else
      render :edit
    end
  end
  def destroy
    if @article.destroy
      redirect_to @article, notice: "記事を削除しました"
    else
      redirect_to @article, notice: "記事を削除出来ませんでした"
    end
  end
  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
