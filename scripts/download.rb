#! /usr/bin/ruby

require 'rake'

if ARGV.length != 1
	puts "Usage: ./" + $PROGRAM_NAME + " <source>"
	puts "Example: ./" + $PROGRAM_NAME + " CAM123"
	exit
end

fn = nil
l = FileList["out/raw/data*"].sort.last

if (l.nil?)
	fn = "data_1"
else
	s = l[/\d+/]
	if (s.nil?)
		puts "Found irregularly-named data file \"out/raw/${l}.\""
		puts "Please remove this file manually to continue."
		exit
	end
	n = s.to_i + 1
	fn = "data_#{n}"
end

# The maximum framerate that is accepted by the server is 1000. Although we will
# not actually get 1000 frames per second, the frame rate will be more steady.
`curl -v -0 -A "GTS VideoClient/2.5" -G -d "source=#{ARGV[0]}&framerate=1000" http://webvideoserv.deldot.gov/video.jpg > out/raw/#{fn}`
