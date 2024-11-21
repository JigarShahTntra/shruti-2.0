class NewsController < ActionController::API
    def index
        newsapi = News.new(Rails.application.credentials.newsapi.key)
        news = newsapi.get_everything(language: "en", q: "fintech", sortBy: "relevancy", searchIn: "title")
        render json: news.as_json, message: "News Fetched Successfully"
    end
end
