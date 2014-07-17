require_relative '../earthquake_yo.rb'

namespace :earthquake_yo do
	desc "pull earthquakes and send yo"
	task :run => :environment do
		EarthquakeApi.run
	end
end