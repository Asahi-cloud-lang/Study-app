class LinebotController < ApplicationController
  require 'line/bot'
  
    def index
        render status: 200 , json: { status: 200, message: "Success" }
    end

    def push
        @task = Task.find(params[:task_id])
        message = {
            type: 'text',
            text: @task.name
        }
        client ||= Line::Bot::Client.new { |config|
            config.channel_id = ENV['CHANNEL_ID']
            config.channel_secret = ENV['CHANNEL_SECRET']
            config.channel_token = ENV['CHANNEL_TOKEN']
        }
        user_id =  ENV['USER_ID']
        response = client.push_message(user_id, message)
        p response
    end
end

