class SinatraApp
  class ApplicationController
  	register Sinatra::SessionAuth
  	
    get '/' do      
      haml :home, :layout => :layout
    end

  end
end
