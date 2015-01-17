require 'rubygems' unless defined? ::Gem
require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/json"
require 'pry' if development?

# require_relative "twilio_action"
# require_relative 'models/init'

class App < Sinatra::Base
    register Sinatra::Reloader

    enable :sessions

    use ActiveRecord::ConnectionAdapters::ConnectionManagement

    configure do
      $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/models")
      require "init"
      $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
      Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| 
        require File.basename(lib, '.*') 
      }
    end
 
    get "/stylesheet/main.css" do
        scss :"scss/main"
    end

    get "/javascript/main.js" do
        coffee :"coffee/main"
    end

    get '/' do
        session[:referer] = request.referer
        erb :index, locals: { test: "yes" }
    end

    get '/instances' do
        json DataCenterManager.new.getInstances
    end

    # post "/call" do 
    #     begin
    #         call = TwilioAction.new.call params["tel"]
    #         Call.new({
    #             tel: params["tel"],
    #             ip: request.ip,
    #             referer: session[:referer],
    #             user_agent: request.user_agent,
    #             status: call.status,
    #             sid: call.sid
    #             }).save
    #         json result: true
    #     rescue => e 
    #         p e
    #         status 500
    #         json result: false
    #     end
    # end

    # get "/twilio.xml" do 
    #     content_type "application/xml"
    #     erb :twilio_response, layout: false
    # end

    # get "/callbak" do 
    #     call = Call.where(sid: params["CallSid"]).first
    #     if call
    #         call.update(status: params["CallStatus"])
    #     end
    #     status 200
    #     "OK"
    # end
end
