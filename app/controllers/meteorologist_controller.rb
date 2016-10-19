require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================


    if @street_address == ""

        @current_temperature = 'N/A'
        @current_summary = 'N/A'
        @summary_of_next_sixty_minutes = 'N/A'
        @summary_of_next_several_hours = 'N/A'
        @summary_of_next_several_days = 'N/A'

      else

        map_break='http://maps.googleapis.com/maps/api/geocode/json?address='
        map = map_break + @street_address_without_spaces

        parsed_data = JSON.parse(open(map).read)

        latitude = parsed_data['results'][0]["geometry"]["location"]["lat"].to_s
        longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s


        coord_break = 'https://api.darksky.net/forecast/b3d079e8705d08518029b0fa1afe8e24/'
        coord = coord_break + latitude + ',' + longitude

        parsed_data = JSON.parse(open(coord).read)

        @current_temperature = parsed_data["currently"]["temperature"]

        @current_summary = parsed_data["currently"]["summary"]

        @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

        @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

        @summary_of_next_several_days = parsed_data["daily"]["summary"]
  end

      render("meteorologist/street_to_weather.html.erb")
    end
  end
