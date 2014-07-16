require_relative '../earthquake_yo.rb'

namespace :earthquake_yo do
	desc "pull earthquakes and send yo"
	task :run => :environment do
		puts "rake ran"
		EarthquakeApi.run
	end
end