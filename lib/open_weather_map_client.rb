require 'net/https'

class OpenWeatherMapClient
  include Singleton

  URL = 'http://api.openweathermap.org/data/2.5'
  API_KEY = '15fba1984c05110d9cd3741f364e6218'

  def initialize
    @uri = URI.parse URL
    @http = Net::HTTP.new @uri.host, @uri.port
  end

  def search(keyword)
    create_request(keyword)

    @res['list'].map do |list|
      main_info = list['main']
      weather_info = list['weather']
      {
        time: list['dt'],
        temp: main_info['temp'],
        feels_like: main_info['feels_like'],
        temp_min: main_info['temp_min'],
        temp_max: main_info['temp_max'],
        pressure: main_info['pressure'],
        humidity: main_info['humidity'],
        main_weather: weather_info[0]['main'],
        description: weather_info[0]['description'],
        clouds: list['clouds']['all'],
        wind: list['wind']['speed'],
      }
    end
  end

  private

    def create_request(keyword)
      req = Net::HTTP::Get.new @uri.path + "/forecast?q=#{keyword},jp&units=metric&APPID=#{API_KEY}"
      _res = @http.request req
      @res = JSON.parse(_res.body)
    end

end