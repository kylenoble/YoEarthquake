require 'clockwork'
require 'config/boot'
require 'config/environment'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  every(65.seconds, 'run earthquakes') {"earthquake_yo:run"}

end