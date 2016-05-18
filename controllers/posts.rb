class PostsController < ApplicationController
  get '/' do
    if !session[:logged_in]
      session[:account_message] = "You must be logged in to post!"
      redirect '/users'
    else
      erb :post
  end





end
