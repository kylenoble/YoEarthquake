require 'json'
require 'net/http'
require 'open-uri'

class EarthquakeApi

	API_TOKEN = ENV["YO_API_TOKEN"]
	API_ENDPOINT = "http://api.justyo.co/yoall/"

	def self.run 
		url = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_hour.geojson"

		if self.should_get_earthquakes?(url)
			self.get_earthquakes
		end
	end

	def self.should_get_earthquakes?(url)

		uri = URI(url)
		res = Net::HTTP.get_response(uri)
		code = res.code

		if code == '404'
			puts "404 error"
			return false
		end
		
		data = res.body
		earthquakes = JSON.parse(data)

		if earthquakes['metadata']['count'] == 0
			@@earthquake_count = 0
			return false
		else 
			@@earthquake_count = earthquakes['metadata']['count']
		end
		
		i = @@earthquake_count - 1
	
		while i >= 0
			time = earthquake_time = earthquakes['features'][i]['properties']["time"]
			if Earthquake.find_by(time: time).nil? #Tests if earthquake exists in the DB
				Earthquake.create!(time: time)
				return true
			end
			i -= 1
		end
		return false
	end

	def self.get_earthquakes
		uri = URI(API_ENDPOINT)
		Net::HTTP.post_form(uri, "api_token" => API_TOKEN) #calls Yo Api
	end

end






