class UsersController < ApplicationController
  # session[:account_message] = ""

  get '/' do
    erb :login
  end

 #-----------  VVVVVVVVVV        Test Paths

  # get '/account' do
  #   if !session[:logged_in]
  #     redirect '/users'
  #   end
  #   @posts_list = Post.all
  #   @update_user = User[id: session[:current_user_id]]
  #   erb :account
  #
  #
  # end

  post '/update' do
    user = User[id: session[:current_user_id]]
    password = BCrypt::Password.create(params[:password_new])
    puts user[:id]
    puts password
    user.password = password
    user.save
    puts user.password
    p "IT UPDATED THE PASSWORD!"
    redirect '/'
  end


  post '/logout' do
    params[:id]
    user = User[id: params[:id]]
    puts user
    user.logged_in = false
    user.save
    puts params
    redirect '/'
  end

  # ---- Test page should display the current user
  get '/whois' do
      user = User[id: session[:current_user_id]]
      "Hello Welcome back #{user[:username]}"
  end


  post '/create' do

    @all_users = User.all
    @all_users.each do |user|
      if (user.username == params[:username])
        status 403
      end
    end

    password = BCrypt::Password.create(params[:password])
    # if params[:username] != User.all.each[:username]
      name = params[:username].downcase.gsub("(", " ").gsub("script", "No Scripts, no exceptions").gsub("iframe", "No Scripts, no exceptions").gsub("error", "No Scripts, no exceptions").gsub(".", " ").gsub(")", " ").gsub("{", " ")
      name2 = name.gsub("$", "No Scripts, no exceptions").gsub("<", " ").gsub(">", " ")

      User.create username: name2, password: password, logged_in: true
      user = User[username: params[:username]]
      session[:logged_in] = true
      session[:username] = params[:username]
      session[:current_user_id] = user[:id]

      logged_in = user[:logged_in]
      redirect '/'

  end




  post '/login' do
    # session[:user_id] = User.authenticate(params).id
    user = User[username: params[:username]]

    compare_to = BCrypt::Password.new(user.password)
    if user && compare_to == params[:password]
      session[:logged_in] = true
      session[:username] = params[:username]
      session[:current_user_id] = user[:id]
      user.logged_in = true
      user.save
      # "Welcome back #{params[:username]}! your session info is #{session[:username]} #{session[:logged_in]}"
      # "hello you are #{session[:username]} Welcome back! Your id is #{session[:current_user_id]} and your karma is #{user[:karma]}"
      session[:account_message] = "Welcome back!"
      redirect '/'


    else
      session[:account_message] = "Your password was wrong.  Try again or call the admin at (800) No-Admin"
      redirect '/users'
    end

  end

  # get '/login' do
  #   # session[:user_id] = User.authenticate(params).id
  #   user = User[username: params[:username]]
  #
  #   compare_to = BCrypt::Password.new(user.password)
  #   if user && compare_to == params[:password]
  #     session[:logged_in] = true
  #     session[:username] = params[:username]
  #     session[:current_user_id] = user[:id]
  #     user.logged_in = true
  #     user.save
  #     # "Welcome back #{params[:username]}! your session info is #{session[:username]} #{session[:logged_in]}"
  #     # "hello you are #{session[:username]} Welcome back! Your id is #{session[:current_user_id]} and your karma is #{user[:karma]}"
  #     session[:account_message] = "Welcome back!"
  #     redirect '/'
  #
  #
  #   else
  #     session[:account_message] = "Your password was wrong.  Try again or call the admin at (800) No-Admin"
  #     redirect '/users'
  #   end
  #
  # end

  get '/logout/?' do

    @logoutuser = User[id: session[:current_user_id]]
    @logoutuser.logged_in = false
    @logoutuser.save
    session[:logged_in] = false
    session[:account_message] = "You have logged out."
    redirect '/'

  end



end
