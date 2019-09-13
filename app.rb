require 'bundler'
require 'action_view'
require "sinatra/activerecord"
require 'uri'
Bundler.require


   set :database, ENV['DATABASE_URL'] || 'postgres://localhost/quoter'
   
class App < Sinatra::Base
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::DateHelper
  include Sinatra::ActiveRecordExtension


  
  Dir["./models/*.rb"].each {|file| require file }
  
  #Let's make sure that the user is signed in as a Herokai or SFDC person
  before do
     
  end
    
  configure do
      set :force_ssl, true
  end

  helpers do
    #pull in the helpers stuff 
    require_relative 'helpers'
  end

  get "/" do
  
  end

  
  
end