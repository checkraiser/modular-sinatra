require "sinatra/activerecord"


class SinatraApp < Sinatra::Base

  @@my_app = {}
  def self.new(*) self < SinatraApp ? super : Rack::URLMap.new(@@my_app) end
  def self.map(url) @@my_app[url] = self end
    
  #use ExceptionHandling
  enable :sessions
  use Rack::Flash
  register Sinatra::ActiveRecordExtension  
  register Sinatra::Can
  set :database_file, "config/database.yml"
  set :dump_errors, false 
  # Don't capture any errors. Throw them up the stack
  set :raise_errors, true
 
  # Disable internal middleware for presenting errors
  # as useful HTML pages
  set :show_exceptions, false
  error 403 do
    'not authorized'
  end

  
  class ApplicationController < SinatraApp
    map '/'
  end

  class CoursesController < SinatraApp
    map '/courses'
  end

  

end
