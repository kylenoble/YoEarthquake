require 'clockwork'
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)

def execute_rake(file,task)
	require 'rake'
	rake = Rake::Application.new
	Rake.application = rake
	Rake::Task.define_task(:environment)
	load "#{Rails.root}/lib/tasks/#{file}"
	rake[task].invoke
  end

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  every(65.seconds, 'run earthquakes') {execute_rake("earthquake_yo.rake","rake earthquake_yo:run")}
end