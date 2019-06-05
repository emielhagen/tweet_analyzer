class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @tweets = Tweet.sync(params[:query])
    else
      @tweets = Tweet.all.sort_by(&:score).reverse!
    end


    respond_to do |format|
      format.html { render 'tweets/index' }
      format.js
    end
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params)

    if @tweet.save
      redirect_to @tweet, notice: 'Tweet was successfully created.'
    else
      render :new
    end
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: 'Tweet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy

    redirect_to tweets_url, notice: 'Tweet was successfully destroyed.'
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:body, :sentiment, :score, :query)
    end
end
