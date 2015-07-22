require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================


url = "https://api.forecast.io/forecast/aab2143d604a9b6130ea6546d66bc846/#{@lat},#{@lng}"
wet_data = open(url).read
parsedd_data = JSON.parse(wet_data)
current_temperature = parsedd_data["currently"]["temperature"]
current_summary = parsedd_data["currently"]["summary"]
summary_of_next_sixty_minutes = parsedd_data["minutely"]["summary"]
summary_of_next_several_hours = parsedd_data["hourly"]["summary"]
summary_of_next_several_days = parsedd_data["daily"]["summary"]


    @current_temperature = current_temperature
    @current_summary = current_summary
    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes
    @summary_of_next_several_hours = summary_of_next_several_hours
    @summary_of_next_several_days = summary_of_next_several_days
    render("coords_to_weather.html.erb")
  end
end
