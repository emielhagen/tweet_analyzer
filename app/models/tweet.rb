class Tweet < ApplicationRecord
  def self.sync(query)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    created = []

    client.search("#{query} -rt").first(500).each do |tweet|
      created << create(body: tweet.text, query: query)
    end


    created.sort_by(&:score).reverse!
  end

  before_save :set_sentiment, if: :body_changed?

  scope :positive, ->{ where(sentiment: :positive) }
  scope :negative, ->{ where(sentiment: :negative) }
  scope :neutral, ->{ where(sentiment: :neutral) }
  scope :scored, ->{ where('score != 0') }

  def set_sentiment
    self.sentiment = $analyzer.sentiment(body)
    self.score = $analyzer.score(body)
  end

  def avg_score
    scores = Tweet.where(query: query).map(&:score)
    scores.reduce(&:+) / scores.count
  end
end
