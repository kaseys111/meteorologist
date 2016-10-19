require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

    if @street_address == ""
          latitude = 'N/A'
          longitude = 'N/A'
        else
          url_break='http://maps.googleapis.com/maps/api/geocode/json?address='
          url = url_break + @street_address_without_spaces

          parsed_data = JSON.parse(open(url).read)

          latitude = parsed_data['results'][0]["geometry"]["location"]["lat"]
          longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

          @latitude = latitude
          @longitude = longitude
        end

        render("geocoding/street_to_coords.html.erb")
      end
    end
