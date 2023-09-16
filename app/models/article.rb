class Article < ApplicationRecord
  belongs_to :user
  has_many :tag_articles, dependent: :destroy
  has_many :tags, through: :tag_articles
  validates :title, presence: true
  validates :content, presence: true
end
