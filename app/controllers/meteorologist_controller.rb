require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

urla = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
street_data = open(urla).read
parsed_data = JSON.parse(street_data)
@latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
@longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

urlb = "https://api.forecast.io/forecast/aab2143d604a9b6130ea6546d66bc846/#{@latitude},#{@longitude}"
rain_data = open(urlb).read
parsedd_data = JSON.parse(rain_data)
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


    render("street_to_weather.html.erb")
  end
end
