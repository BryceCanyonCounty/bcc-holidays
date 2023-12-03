if Config.WeatherActive == true then
    exports.weathersync:setWeather(Config.ServerStartupWeather, 0.1, false, Config.PermanentSnow)
end
