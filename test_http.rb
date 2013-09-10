require 'rubygems'
require 'sinatra'
require 'webrick'
require 'erb'
require 'recaptcha'
require 'net/http'



Recaptcha.configure do |config|
  config.public_key  = 'Pub_key_there'
  config.private_key = 'Private_key_there'
  config.use_ssl_by_default
end


webrick_options = {
        :Port               => 9081,
        :debugger           => false,
        :SSLEnable          => false,
}

class MyServer  < Sinatra::Base

include Recaptcha::ClientHelper
include Recaptcha::Verify
 
get '/' do

 erb :check

end #end get

post '/' do

 if verify_recaptcha then
    "pass recapcha!"
 else
    "failed recapcha!"
 end #end if

end #end post

      
end

Rack::Handler::WEBrick.run MyServer, webrick_options
