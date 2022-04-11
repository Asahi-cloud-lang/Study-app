class UsersController < ApplicationController
  require 'httpclient'
  require 'net/http'
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]

  def show
    require 'news-api'
    news = News.new(ENV['NEWS_API_KEY'])
    @allnews = news.get_top_headlines(country: 'jp')
    @news = Kaminari.paginate_array(@allnews).page(params[:page]).per(3)
    
    @tasks = Task.where(user_id: @user.id).where(status: false)
    @sum = 10
    
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
    params = URI.encode_www_form({q: 'Atsugi', units: 'metric', appid: ENV['WEATHER_API_KEY']})
    # URIを解析し、hostやportをバラバラに取得できるようにする
    uri = URI.parse("http://api.openweathermap.org/data/2.5/forecast?#{params}")
    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query

    # 新しくHTTPセッションを開始し、結果をresponseへ格納
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      # 接続時に待つ最大秒数を設定
      http.open_timeout = 5
      # 読み込み一回でブロックして良い最大秒数を設定
      http.read_timeout = 10
      # ここでWebAPIを叩いている
      # Net::HTTPResponseのインスタンスが返ってくる
      http.get(uri.request_uri)
    end
    # 例外処理の開始
    begin
      # responseの値に応じて処理を分ける
      case response
      # 成功した場合
      when Net::HTTPSuccess
        # responseのbody要素をJSON形式で解釈し、hashに変換
        @result = JSON.parse(response.body)
        # 表示用の変数に結果を格納
        
        # 天気
        @weather = @result["list"][0]["weather"][0]["description"]
        if @weather = "clear sky"
          @weather = "晴れ"
          @img_url = 'clear_sky.png'
        elsif @weather = "scattered cloud"
          @weather = "曇りのち晴れ"
          @img_url = 'scattered_cloud.png'
        elsif  @weather = "thunderstorm rain"
          @weather = "雨のち雷"
          @img_url = 'thunderstorm_rain.png'
        elsif  @weather = "thunderstorm"
          @weather = "雷"
          @img_url = 'thunderstorm.png'
        elsif  @weather = "rain"
          @weather = "雨"
          @img_url = 'rain.png'
        elsif  @weather = "snow"
          @weather = "雪"
          @img_url = 'snow.png'
        elsif  @weather = "light rain"
          @weather = "小雨"
          @img_url = 'light_rain.png'
        elsif  @weather = "drizzle"
          @weather = "霧"
          @img_url = 'drizzle.png'
        elsif  @weather = "cloud"
          @weather = "曇り"
          @img_url = 'cloud.png'
        end
        
        # 今の気温
        @now_temp_max = @result["list"][0]["main"]["temp_max"]
        
        # 3時間後の気温
        @three_temp_max = @result["list"][3]["main"]["temp_max"]
        
        # 6時間後の気温
        @six_temp_max = @result["list"][6]["main"]["temp_max"]
        
        # 9時間後の気温
        @nine_temp_max = @result["list"][6]["main"]["temp_max"]
        
        # 最低気温
        @temp_min = @result["list"][0]["main"]["temp_min"]
        
        # 風速
        @speed = @result["list"][0]["wind"]["speed"]
        
      # 別のURLに飛ばされた場合
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      # その他エラー
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    # エラー時処理
    rescue IOError => e
      @message = "e.message"
    rescue TimeoutError => e
      @message = "e.message"
    rescue JSON::ParserError => e
      @message = "e.message"
    rescue => e
      @message = "e.message"
    end
    
    @today = Date.today
    day = Date.today.wday
    days = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
    @week = days[day]
  end
    

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
    flash[:success] = "#{@user.name}の基本情報を更新しました。"
  else
    flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
  end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
end