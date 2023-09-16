class MypageController < ApplicationController
  def index
    # @articles = Article.where(user: current_user)
    @articles = current_user.articles.preload(:tags).page(params[:page])
  end
  def search
    @articles = current_user.articles.where('title LIKE(?)', "%#{params[:title]}%")
    @articles = @articles.page(params[:page])
    render 'index'
  end
end
