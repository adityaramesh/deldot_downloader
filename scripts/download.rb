#! /usr/bin/ruby

require 'rake'

if ARGV.length != 1
	puts "Usage: ./" + $PROGRAM_NAME + " <source>"
	puts "Example: ./" + $PROGRAM_NAME + " CAM123"
	exit
end

loop do
	bn = ARGV[0].downcase
	fn = nil
	l = FileList["out/raw/#{bn}*"].sort.last

	if (l.nil?)
		fn = bn + ".1"
	else
		s = l.scan(/\d+/).last
		n = s.to_i + 1
		fn = "#{bn}.#{n}"
	end

	# The maximum framerate that is accepted by the server is 1000. Although we will
	# not actually get 1000 frames per second, the frame rate will be more steady.
	`curl -v -0 -A "GTS VideoClient/2.5" -G -d "source=#{ARGV[0]}&framerate=1000" http://webvideoserv.deldot.gov/video.jpg 1> out/raw/#{fn} 2> /dev/null`
	if (!$?.success?)
		exit
	end
end
