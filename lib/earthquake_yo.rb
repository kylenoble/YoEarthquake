require 'json'
require 'net/http'
require 'open-uri'

class EarthquakeApi

	API_TOKEN = ENV["YO_API_TOKEN"]
	API_ENDPOINT = "http://api.justyo.co/yoall/"
<<<<<<< HEAD
	API_URL = "http://goo.gl/77Fua4"
=======
	API_LINK = "http://goo.gl/77Fua4"
>>>>>>> 3182c477454cfcdedb38b2df7c6353deda51a4e5

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
			time = earthquakes['features'][i]['properties']["time"]
			mag = earthquakes['features'][i]['properties']["mag"].to_f
			if Earthquake.find_by(time: time).nil? && mag >= 6.0 #Tests if earthquake exists in the DB and if quake is larger than 6.0
				Earthquake.create!(time: time)
				return true
			end
			i -= 1
		end
		return false
	end

	def self.get_earthquakes
		uri = URI(API_ENDPOINT)
		Net::HTTP.post_form(uri, "api_token" => API_TOKEN, "link" => API_URL) #calls Yo Api
	end

end






