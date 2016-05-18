class ApplicationController < Sinatra::Base
  set :public_folder, File.expand_path('../../public', __FILE__)
  set :views, File.expand_path('../../views', __FILE__)

  enable :sessions

  before do
    @current_user = session[:username]
    if session[:logged_in] == true
      user = User[id: session[:current_user_id]]
    end
  end

  # Path for testing: Should display current user's username
  get '/whois' do
      user = User[id: session[:current_user_id]]
      "Hello Welcome back #{user[:username]}"
  end

  get '/' do
    @posts = Post.all
    erb :homepage
  end

  get '/about' do
    erb :about
  end



  not_found do
    erb :notfound
  end



end
