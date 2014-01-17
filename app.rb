require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

get "/" do
	erb :index	
end

post '/result' do
	search_str = params[:movie]
  request = Typhoeus.get("www.omdbapi.com", :params => {:s => search_str})
  @movie = JSON.parse(request.body)["Search"].sort_by { |x| x["Year"]}.reverse
	erb :results
end

get '/details/:imdb' do |imdb_id|
  request = Typhoeus.get("www.omdbapi.com", :params => {:i => imdb_id})
  @id = JSON.parse(request.body)
  erb :details
end