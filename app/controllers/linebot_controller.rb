class LinebotController < ApplicationController
  require 'line/bot'
  
    def index
        render status: 200 , json: { status: 200, message: "Success" }
    end

    def push
        @task = Task.find(params[:task_id])
        client ||= Line::Bot::Client.new { |config|
            config.channel_id = ENV['CHANNEL_ID']
            config.channel_secret = ENV['CHANNEL_SECRET']
            config.channel_token = ENV['CHANNEL_TOKEN']
        }
        message={
            type: 'text',
            text: 'hellot'
           }
        user_id =  ENV['USER_ID']
        response = client.broadcast(message)
        p response
    end
end

