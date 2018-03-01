require 'yaml/store'
require 'yaml'
require 'sinatra'

Feeds = {
  
}

get '/' do
  @title = 'Freedom Board!'
  @search = ''
  erb :start
end

post '/post' do
  @title = 'Freedom Board'
  @message  = params['message']
  @user  = params['user']
  @search = ''
  @store = YAML::Store.new 'posts.yml'
  @time = Time.now.strftime("%d/%m/%Y %H:%M:%S")
  @store.transaction do
    @store ||= {}
    @store[@user+" "+@time] ||= ''
    @store[@user+" "+@time] += @message
  end
  erb :start
end

post '/search' do
  @title = 'Freedom Board'
  @search  = params['search']
  erb :start
end

get '/' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'posts.yml'
  @posts = @store.transaction { @store['posts'] }
  erb :start
end
