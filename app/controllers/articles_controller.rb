class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ edit update destroy ]
  before_action :set_tag, only: %i[ create update ]
  skip_before_action :authenticate_user!, only: %i[ index show ]

  def index
    @articles = Article.preload(:tags).all.page(params[:page])
  end
  def search
    #articleのtitleを曖昧検索
    @articles = Article.where('title LIKE(?)', "%#{params[:title]}%")
    @articles = @articles.page(params[:page])
    render 'index'
  end
  def show
    @article = Article.find(params[:id])
  end
  def edit
  end
  def new
    @article = Article.new
  end
  def create
    # @article = Article.new(article_params)
    # @article.user_id = current_user.id
    @article = current_user.articles.new(article_params)
    if @article.save
      save_tag
      redirect_to @article, notice: "記事を作成しました"
    else
      render :new
    end
  end
  def update
    if @article.update(article_params)
      save_tag
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
    # @article = Article.find(params[:id])
    # @article.user_id = current_user.id
    @article = current_user.articles.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :content)
    # params.require(:article).permit(:title, :content, tag_ids:[])
  end
  def set_tag
    @tag_ids = params[:article][:tag_ids]
    @tag_ids.shift
  end
  def save_tag
    @tag_ids.each do |tag_id|
      tag = Tag.find(tag_id.to_i)
      @article.tags << tag #関連付ける
    end
  end
end
