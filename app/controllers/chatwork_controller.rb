class ChatworkController < ApplicationController
  require 'net/https'
  require 'uri'
  require 'json'

  def push_chatwork_message
    @task = Task.find(params[:task_id])
    chatwork_room_id = ENV['CHATWORK_ROOM_ID']
    chatwork_api_token = ENV['CHATWORK_API_TOKEN']

    uri = URI.parse("https://api.chatwork.com/v2/rooms/#{chatwork_room_id}/messages")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    start_day = @task.start_day.strftime("%Y-%m-%d") 
    finish_day = @task.finish_day.strftime("%Y-%m-%d") 

    message = "【名前】 " + @task.name + "　【詳細】 " + @task.detail + "　【開始日】 " +  start_day.to_s + "　【終了日】 " + finish_day.to_s + " 【進捗率】　" + @task.progress.to_s + "%"

    http.start do
      req = Net::HTTP::Post.new(uri.path)
      req['X-ChatWorkToken'] = chatwork_api_token
      req.set_form_data(body: message)
      http.request(req)
    end
  end
end

