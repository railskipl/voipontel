require 'net/http'
    require 'uri' 
    require 'open-uri'
    require 'nokogiri'
class SessionsController < ApplicationController
  def new
   @title = "Sign in"
	
  end

# Login Method used to Login & redirect the user to the MOR dashboard
  def create
  
     a = "http://67.215.224.75/billing/api/login?u=#{params[:session][:email]}&p=#{params[:session][:password]}"   
     
     # Nokogiri Gem is used to Catch the XML response from the MOR & call the appropriate action on the received status
     
      doc = Nokogiri::XML(open(a))
         doc.xpath('/action/status').each do |link|  
        @abc = link.content
         end 
        
        # Condition to check whether the received response is 'Ok' or 'Failed' 
        
        if @abc == 'failed'
               
                flash[:notice] = "Invalid Username/Password" # If condition is failed redirect to root page
                 redirect_to '/' 
               else
               		# if condition is 'ok' redirect to MOR user dashboard
               		
                   redirect_to "http://67.215.224.75/billing/api/login?u=#{params[:session][:email]}&p=#{params[:session][:password]}"
             end                                        
 end  

  def destroy
    sign_out
    cookies.delete(:auth_token)
    redirect_to root_path
  end
end

# MOR API for User sign in Keep commented & Do not remove the below line
#http://<SERVER_IP>/billing/api/login?u=username&p=password

